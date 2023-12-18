import 'package:coal_tracking_app/controllers/logs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LogsPage extends StatelessWidget {
  final LogsController logsController = Get.put(LogsController());

  LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Logs'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order IDs:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: logsController.displayedOrderIds.map(
                  (orderId) {
                    return ActionChip(
                      padding: const EdgeInsets.all(8),
                      label: Text(
                        orderId,
                        style: TextStyle(
                          color: logsController.selectedOrderId == orderId
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      backgroundColor: logsController.selectedOrderId == orderId
                          ? Colors.blue
                          : null,
                      onPressed: () async {
                        await logsController.onOrderIdSelected(orderId);
                      },
                    );
                  },
                ).toList(),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                height:
                    40, // Define a specific height for the row of indicators
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (logsController.allOrderIds.length /
                          logsController.itemsPerPage)
                      .ceil(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          logsController.onPageSelected(index);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: logsController.currentPage == index
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Location Logs for selected Order ID:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: logsController.locations.length,
                  itemBuilder: (context, index) {
                    DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
                        logsController.locations[index].timestamp);
                    return ListTile(
                      title: Text(
                        'Latitude: ${logsController.locations[index].latitude}, Longitude: ${logsController.locations[index].longitude}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      subtitle: Text(
                        'Timestamp: ${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute}:${timestamp.second}',
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
