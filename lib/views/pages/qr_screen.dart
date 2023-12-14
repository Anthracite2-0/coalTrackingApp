import 'package:coal_tracking_app/views/pages/google_map_utils/current_location.dart';
import 'package:coal_tracking_app/views/pages/map_screen.dart';
import 'package:coal_tracking_app/views/pages/output.dart';
import 'package:coal_tracking_app/views/pages/qr_overlay.dart';
import 'package:coal_tracking_app/views/pages/trip_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRSCreen extends StatefulWidget {
  const QRSCreen({Key? key}) : super(key: key);

  @override
  State<QRSCreen> createState() => _QRSCreenState();
}

class _QRSCreenState extends State<QRSCreen> {
  MobileScannerController cameraController = MobileScannerController();

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          //title: const Text('QRScanner'),
          actions: [
            IconButton(
                onPressed: () {
                  cameraController.switchCamera();
                },
                icon: const Icon(Icons.camera_rear_outlined))
          ],
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  Position position = await _determinePosition();

                  Get.to(TripDetails(
                    originLatitude: position.latitude!,
                    originLongitude: position.longitude!,
                    destLatitude: 28.6613,
                    destLongitude: 77.4922,
                  ));

                  // ));
                }
              },
            ),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
          ],
        ));
  }
}
