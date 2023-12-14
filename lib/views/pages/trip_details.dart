import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/pages/map_screen.dart';
import 'package:coal_tracking_app/views/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDetails extends StatefulWidget {
  final double originLatitude;
  final double originLongitude;
  final double destLatitude;
  final double destLongitude;
  const TripDetails(
      {Key? key,
      required this.originLatitude,
      required this.originLongitude,
      required this.destLatitude,
      required this.destLongitude})
      : super(key: key);

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  //String googleAPiKey = "AIzaSyDQ2c_pOSOFYSjxGMwkFvCVWKjYOM9siow";
  String googleAPiKey = apiKey;

  @override
  void initState() {
    super.initState();

    /// origin marker
    _addMarker(LatLng(widget.originLatitude, widget.originLongitude), "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.destLatitude, widget.destLongitude), "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));
    _getPolyline();
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Selection made'),
      duration: Duration(milliseconds: 80),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: Stack(alignment: Alignment.bottomCenter, children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(widget.originLatitude, widget.originLongitude),
              zoom: 15),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          tiltGesturesEnabled: true,
          mapType: MapType.hybrid,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        ),
        Container(
          height: MediaQuery.of(context).size.height * .2,
          width: w * 1,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(40)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      //Get.to(HomePage());
                      //showSnackBar(context);
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Decline",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      //showSnackBar(context);
                      Get.to(MapScreen(
                          originLatitude: widget.originLatitude,
                          originLongitude: widget.originLongitude,
                          destLatitude: widget.destLatitude,
                          destLongitude: widget.destLongitude));
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.4,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "Accept",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ])),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(widget.originLatitude, widget.originLongitude),
        PointLatLng(widget.destLatitude, widget.destLongitude),
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
