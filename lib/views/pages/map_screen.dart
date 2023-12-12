import 'package:coal_tracking_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final double originLatitude;
  final double originLongitude;
  final double destLatitude;
  final double destLongitude;
  const MapScreen(
      {Key? key,
      required this.originLatitude,
      required this.originLongitude,
      required this.destLatitude,
      required this.destLongitude})
      : super(key: key);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [
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
        Positioned(
            bottom: 30,
            left: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              child: Center(
                child: IconButton(
                  icon: Icon(
                    Icons.navigation_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        'google.navigation:q=${widget.destLatitude}, ${widget.destLongitude}&key=AIzaSyCtz4qxThjgX4v-LqdqyHsqLMpUVvGAi3E'));
                  },
                ),
              ),
            ))
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
