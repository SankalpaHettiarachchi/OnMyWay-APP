import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onmyway/views/functions/location_services.dart';

class CustomerMap extends StatefulWidget {
  const CustomerMap({super.key});

  @override
  State<CustomerMap> createState() => MapSampleState();
}

class MapSampleState extends State<CustomerMap> {
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();

  TextEditingController _searchController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.357761656705298, 80.5084357626636),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _setMarker(LatLng(8.357761656705298, 80.5084357626636));
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: point,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Map'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: _searchController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(hintText: 'Start Location'),
                onChanged: (value) {
                  print(value);
                },
              )),
              IconButton(
                onPressed: () async {
                  var place =
                      await LocationService().getPlace(_searchController.text);
                  _goToCity(place);
                },
                icon: Icon(
                  Icons.search,
                ),
              )
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              markers: _markers,
              polygons: _polygons,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToCity(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );
    _setMarker(LatLng(lat, lng));
  }
}
