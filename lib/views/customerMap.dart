import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onmyway/components/location_list_tile.dart';
import 'package:onmyway/components/network_utility.dart';
import 'package:onmyway/constants/constants.dart';
import 'package:onmyway/models/autocomplete_prediction.dart';
import 'package:onmyway/models/place_auto_complete_response.dart';
import 'package:onmyway/views/functions/location_services.dart';

class CustomerMap extends StatefulWidget {
  const CustomerMap({super.key});

  @override
  State<CustomerMap> createState() => MapSampleState();
}

class MapSampleState extends State<CustomerMap> {
  Set<Marker> _markers = Set<Marker>();
  Set<Polygon> _polygons = Set<Polygon>();
  Set<Polyline> _polylines = Set<Polyline>();

  int _polylineIdCounter = 1;

  TextEditingController _originController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

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

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdval = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdval),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  List<AutocompletePrediction> placePredictions = [];

  void placeAutocomplete(String query) async {
    Uri uri =
        Uri.https("maps.googleapis.com", 'maps/api/place/autocomplete/json', {
      "input": query,
      "key": 'AIzaSyBxTN-GDUxbM30SgiKqEVrJdpZ3DrEGPyI',
    });
    String? response = await NetworkUtility.fetchUrl(uri);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          placePredictions = result.predictions!;
        });
      }
    }
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
                  child: Column(
                children: [
                  TextFormField(
                    controller: _originController,
                    decoration: InputDecoration(hintText: 'Start Location'),
                    onChanged: (value) {
                      placeAutocomplete(value);
                    },
                  ),
                  const Divider(
                    height: 4,
                    thickness: 4,
                    color: Colors.amberAccent,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: placePredictions.length,
                        itemBuilder: (context, index) => LocationListTile(
                          press: () {},
                          location: placePredictions[index].description!,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _destinationController,
                    decoration: InputDecoration(hintText: 'End Location'),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                  const Divider(
                    height: 4,
                    thickness: 4,
                    color: Colors.amberAccent,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: placePredictions.length,
                        itemBuilder: (context, index) => LocationListTile(
                          press: () {},
                          location: placePredictions[index].description!,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
              IconButton(
                onPressed: () async {
                  var directions = await LocationService().getDirection(
                      _originController.text, _destinationController.text);
                  _goToCity(
                    directions['start_location']['lat'],
                    directions['start_location']['lng'],
                    directions['bounds_ne'],
                    directions['bounds_sw'],
                  );
                  _setPolyline(directions['polyline_decoded']);
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.terrain,
              markers: _markers,
              polygons: _polygons,
              polylines: _polylines,
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

  Future<void> _goToCity(
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    // final double lat = place['geometry']['location']['lat'];
    // final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng']),
          ),
          25),
    );
    _setMarker(LatLng(lat, lng));
  }
}
