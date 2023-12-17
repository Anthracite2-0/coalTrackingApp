import 'package:coal_tracking_app/models/qr_model.dart';
import 'package:coal_tracking_app/views/pages/qr_overlay.dart';
import 'package:coal_tracking_app/views/pages/trip_details.dart';
import 'package:coal_tracking_app/views/widgets/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScreen extends StatefulWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  State<QRScreen> createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isLoading = false;
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

  Map<String, double> parseGeoData(String geoData) {
    List<String> parts = geoData.split(':');
    List<String> coordinates = parts[1].split(',');

    double latitude = double.parse(coordinates[0]);
    double longitude = double.parse(coordinates[1]);

    return {'latitude': latitude, 'longitude': longitude};
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
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) async {
              setState(() {
                _isLoading = true;
              });
              final List<Barcode> barcodes = capture.barcodes;
              //final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                if (kDebugMode) {
                  print(barcode.rawValue);
                }
                if (barcode.rawValue!.contains('final_destination')) {
                  // print(barcode.rawValue);
                  QRModel qrmodel = qrModelJson(barcode.rawValue!);
                  // Map<String, double> geoData =
                  //     parseGeoData(barcode.rawValue!);
                  //debugPrint('Barcode found! ${geoData['latitude']}');
                  Position position = await _determinePosition();
                  setState(() {
                    _isLoading = false;
                  });
                  Get.off(
                    TripDetails(
                      originLatitude: position.latitude,
                      originLongitude: position.longitude,
                      destLatitude: qrmodel.finalDestination!.lat!,
                      destLongitude: qrmodel.finalDestination!.lng!,
                    ),
                  );
                }
              }
            },
          ),
          QRScannerOverlay(
            overlayColour: Colors.black.withOpacity(0.5),
          ),
          if (_isLoading)
            const Center(
              child: Loading(),
            )
        ],
      ),
    );
  }
}
