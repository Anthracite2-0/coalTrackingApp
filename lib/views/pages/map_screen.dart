import 'dart:async';
import 'dart:ui' as ui;

import 'package:coal_tracking_app/controllers/map_controller.dart';
import 'package:coal_tracking_app/interface/backend_interface.dart';
import 'package:coal_tracking_app/models/send_coordinates_reqeust_model.dart';
import 'package:coal_tracking_app/models/send_coordinates_resposne_model.dart';
import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/widgets/loading.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    Key? key,
  }) : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class LocationCoordinates {
  double latitude;
  double longitude;

  LocationCoordinates(this.latitude, this.longitude);
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = apiKey;
  final MapController _mapController = Get.put(MapController());
  double initialLat = 0.0;
  double initialLong = 0.0;
  double finalLat = 0.0;
  double finalLong = 0.0;
  // double x = 24.00;
  // double y = 79.00;

  List<String> images = [
    'assets/images/box-truck.png',
  ];

  List<LocationCoordinates> locationCoordinates = [
    LocationCoordinates(23.85396378280531, 85.00255309746714),
    LocationCoordinates(23.850426, 85.004055),
    LocationCoordinates(23.846559, 85.001866),
    LocationCoordinates(23.846264, 85.000844),
    LocationCoordinates(23.844746, 84.996053),
    LocationCoordinates(23.843114, 84.995305),
    LocationCoordinates(23.838560, 84.997812),
    LocationCoordinates(23.837830, 85.001955),
    LocationCoordinates(23.835102, 85.004151),
    LocationCoordinates(23.831736, 85.003627),
    LocationCoordinates(23.828916, 85.003115),
    LocationCoordinates(23.825812, 85.002803),
    LocationCoordinates(23.822719, 85.001531),
    LocationCoordinates(23.818433, 84.982927),
    LocationCoordinates(23.809666, 84.966557),
    LocationCoordinates(23.800168, 84.958173),
    LocationCoordinates(23.785920, 84.941004),
    LocationCoordinates(23.766921, 84.914253),
    LocationCoordinates(23.711732, 84.923436),
    LocationCoordinates(23.691259, 84.941004),
    LocationCoordinates(23.678096, 84.950986),
    LocationCoordinates(23.670143, 84.955577),
    LocationCoordinates(23.658075, 84.954579),
    LocationCoordinates(23.657527, 84.947792),
    LocationCoordinates(23.657412166574847, 84.94272979898822),
  ];

  Uint8List? markerImage;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    print("In mapscreen ");
    _mapController.getMapData().then((_) => _loadData());
    // initialLat = double.parse(_mapController.initialLtd.value);
    // initialLong = double.parse(_mapController.initialLong.value);
    // finalLat = double.parse(_mapController.finalLat.value);
    // finalLong = double.parse(_mapController.finalLong.value);
    // print(double.parse(_mapController.finalLat.value));

    // /// origin marker
    // _addMarker(
    //     LatLng(double.parse(_mapController.initialLtd.value),
    //         double.parse(_mapController.initialLong.value)),
    //     "origin",
    //     BitmapDescriptor.defaultMarker);
    // print(double.parse(_mapController.finalLat.value));

    // /// destination marker
    // _addMarker(
    //     LatLng(double.parse(_mapController.finalLat.value),
    //         double.parse(_mapController.finalLong.value)),
    //     "destination",
    //     BitmapDescriptor.defaultMarkerWithHue(90));

    // _getPolyline();
    // _loadData();
  }

  Future<void> _loadData() async {
    //print(double.parse(_mapController.finalLat.value));

    /// origin marker
    await _addMarker(
        LatLng(double.parse(_mapController.initialLtd.value),
            double.parse(_mapController.initialLong.value)),
        "origin",
        BitmapDescriptor.defaultMarker);
    // print(double.parse(_mapController.finalLat.value));

    /// destination marker
    await _addMarker(
        LatLng(double.parse(_mapController.finalLat.value),
            double.parse(_mapController.finalLong.value)),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    await _getPolyline();
    // Position position = await _determinePosition();
    LocationCoordinates position = locationCoordinates[0];

    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(double.parse(_mapController.initialLtd.value),
            double.parse(_mapController.initialLong.value)),
        zoom: 14)));

    markers.clear();

    await _addTruckMarker(
        LatLng(position.latitude, position.longitude), "truck");
    await _addMarker(
        LatLng(double.parse(_mapController.initialLtd.value),
            double.parse(_mapController.initialLong.value)),
        "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    await _addMarker(
        LatLng(double.parse(_mapController.finalLat.value),
            double.parse(_mapController.finalLong.value)),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    setState(() {});
    Timer.periodic(const Duration(seconds: 5), (timer) {
      sendCoordinates(
          position.latitude.toString(), position.longitude.toString());
      _updateData();
      print("Hooo");
    });
  }

  Future<void> _updateData() async {
    final i = _mapController.iterLoc.value;
    if (i == locationCoordinates.length) {
      return;
    }
    // Position position = await _determinePosition();
    LocationCoordinates position = locationCoordinates[i];
    markers.clear();

    await _addTruckMarker(
        LatLng(position.latitude, position.longitude), "truck");
    await _addMarker(
        LatLng(double.parse(_mapController.initialLtd.value),
            double.parse(_mapController.initialLong.value)),
        "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    await _addMarker(
        LatLng(double.parse(_mapController.finalLat.value),
            double.parse(_mapController.finalLong.value)),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    setState(() {
      _mapController.incrementIterLoc();
    });
  }

  Future<void> sendCoordinates(String lat, String long) async {
    // SendCoordinatesRequestModel sendCoordinatesRequestModel =
    //     SendCoordinatesRequestModel(
    //         currentLat: x.toString(),
    //         currentLong: y.toString(),
    //         driverId: "9",
    //         orderId: "10");
    SendCoordinatesRequestModel sendCoordinatesRequestModel =
        SendCoordinatesRequestModel(
            currentLat: lat, currentLong: long, driverId: "9", orderId: "10");
    SendCoordinatesResponseModel sendCoordinatesResponseModel =
        await BackendInterface.sendCoordinates(
      sendCoordinatesRequestModel,
    );
    setState(() {});
    // print(x);
    // setState(() {
    //   x = x + 0.05;
    //   y = y + 0.05;
    // });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          if (_mapController.isLoading.value == true) {
            return const Center(child: Loading());
          } else {
            return Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(initialLat, initialLong), zoom: 15),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                tiltGesturesEnabled: true,
                mapType: MapType.terrain,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
                onTap: (position) {
                  _customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  _customInfoWindowController.onCameraMove!();
                },
              ),
              Positioned(
                  bottom: 30,
                  left: 20,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.navigation_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          await launchUrl(Uri.parse(
                              'google.navigation:q=${finalLat}, ${finalLong}&key=AIzaSyCtz4qxThjgX4v-LqdqyHsqLMpUVvGAi3E'));
                        },
                      ),
                    ),
                  )),
              CustomInfoWindow(
                controller: _customInfoWindowController,
                height: 200,
                width: 300,
                offset: 35,
              ),
            ]);
          }
        }),

        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () async {
        //     setState(() {});
        //   },
        //   label: const Text("Current Location"),
        //   icon: const Icon(Icons.location_history),
        // )
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    _customInfoWindowController.googleMapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addTruckMarker(LatLng position, String id) async {
    MarkerId markerId = MarkerId(id);
    final Uint8List markerIcon =
        await getBytesFromAsset(images[0].toString(), 100);

    BitmapDescriptor descriptor = BitmapDescriptor.fromBytes(markerIcon);

    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      onTap: () {
        _customInfoWindowController.addInfoWindow!(
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 300,
                  height: 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg'),
                        fit: BoxFit.fitWidth,
                        filterQuality: FilterQuality.high),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    color: Colors.red,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          'Beef Tacos',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      Spacer(),
                      Text(
                        '.3 mi.',
                        // widget.data!.date!,
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Text(
                    'Help me finish these tacos! I got a platter from Costco and it’s too much.',
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          LatLng(position.latitude, position.longitude),
        );
      },
    );
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(double.parse(_mapController.initialLtd.value),
            double.parse(_mapController.initialLong.value)),
        PointLatLng(double.parse(_mapController.finalLat.value),
            double.parse(_mapController.finalLong.value)),
        travelMode: TravelMode.driving,
        wayPoints: [PolylineWayPoint(location: "")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
