import 'package:coal_tracking_app/views/pages/output.dart';
import 'package:coal_tracking_app/views/pages/qr_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRSCreen extends StatefulWidget {
  const QRSCreen({Key? key}) : super(key: key);

  @override
  State<QRSCreen> createState() => _QRSCreenState();
}

class _QRSCreenState extends State<QRSCreen> {
  MobileScannerController cameraController = MobileScannerController();
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
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  debugPrint('Barcode found! ${barcode.rawValue}');
                  Get.to(Output(
                    riddle: barcode.rawValue,
                  ));
                }
              },
            ),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5))
          ],
          // child: MobileScanner(
          //   controller: cameraController,
          //   onDetect: (capture) {
          //     final List<Barcode> barcodes = capture.barcodes;
          //     final Uint8List? image = capture.image;
          //     for (final barcode in barcodes) {
          //       debugPrint('Barcode found! ${barcode.rawValue}');
          //     }
          //   },
          // ),
        ));
  }
}
