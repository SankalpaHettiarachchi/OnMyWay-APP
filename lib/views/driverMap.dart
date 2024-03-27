import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:onmyway/constants/constants.dart';

class DriverMap extends StatefulWidget {
  const DriverMap({super.key});

  @override
  State<DriverMap> createState() => _DriverMapState();
}

class _DriverMapState extends State<DriverMap> {
  Location _locationController = new Location();
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  static const LatLng _mihinthale =
      LatLng(8.358727143281959, 80.51152191826883);

  static const LatLng _yapane_junc = LatLng(8.355567, 80.417037);

  LatLng? _currentP = null;
  Map<PolylineId, Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    getLocationUpdate().then((_) => {
          getPolyLinePoints().then((coordinates) => {
                generatePolyLineFromPoints(coordinates),
              }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentP == null
          ? Center(
              child: Text('Loading..'),
            )
          : GoogleMap(
              onMapCreated: ((GoogleMapController controller) =>
                  _mapController.complete(controller)),
              initialCameraPosition: CameraPosition(
                target: _mihinthale,
                zoom: 13,
              ),
              markers: {
                Marker(
                    markerId: MarkerId("_liveLocation"),
                    infoWindow: InfoWindow(title:"OnMyWay...."),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                    position: _currentP!),
                Marker(
                    markerId: MarkerId("_sourceLocation"),
                    infoWindow: InfoWindow(title:"Start"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    position: _mihinthale),
                Marker(
                    markerId: MarkerId("_destination"),
                    infoWindow: InfoWindow(title:"Destination"),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                    position: _yapane_junc)
              },
              polylines: Set<Polyline>.of(polylines.values),
            ),
    );
  }

  Future<void> _cameraToPosition(LatLng pos) async {
    final GoogleMapController controller = await _mapController.future;
    CameraPosition _newCameraPosition = CameraPosition(target: pos, zoom: 13);
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(_newCameraPosition),
    );
  }

  Future<void> getLocationUpdate() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }

    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _currentP =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          // _cameraToPosition(_currentP!);
          print("Start Location : - $_mihinthale");
          print("Live Location : - $_currentP");
          print("End Location : - $_yapane_junc");
        });
      }
    });
  }

  Future<List<LatLng>> getPolyLinePoints() async {
    List<LatLng> polyLineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      GOOGLE_MAPS_API_KEY,
      PointLatLng(_mihinthale.latitude, _mihinthale.longitude),
      PointLatLng(_yapane_junc.latitude, _yapane_junc.longitude),
      travelMode: TravelMode.driving,
    );
    print(result);

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    return polyLineCoordinates;
  }

  void generatePolyLineFromPoints(List<LatLng> polyLineCoordinates) async {
    PolylineId id = PolylineId("Poly");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.black,
        points: polyLineCoordinates,
        width: 8);
    setState(
      () {
        polylines[id] = polyline;
      },
    );
  }
}
