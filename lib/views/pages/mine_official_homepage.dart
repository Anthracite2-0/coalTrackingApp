import 'dart:ui';

import 'package:coal_tracking_app/interface/backend_interface.dart';
import 'package:coal_tracking_app/models/train_location_request_model.dart';
import 'package:coal_tracking_app/models/train_status_request_model.dart';
import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/pages/empty.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/chat.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/notifications.dart';
import 'package:coal_tracking_app/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineOfficialHomepage extends StatefulWidget {
  const MineOfficialHomepage({super.key});

  @override
  State<MineOfficialHomepage> createState() => _MineOfficialHomepageState();
}

class _MineOfficialHomepageState extends State<MineOfficialHomepage> {
  bool isChecked = false;
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    List<String> item = ["0", "1", "2", "3"];
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 13.0,
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(-20.0, 0.0, 0.0),
          child: const Text(
            "Bhopal, M.P.",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        leading: const Row(
          children: [
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.location_on,
              color: Colors.black,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const Notifications());
            },
            icon: const Icon(
              Icons.notifications,
              color: Color(0xff161A30),
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(const Chat());
            },
            icon: const Icon(
              Icons.chat,
              color: Color(0xff161A30),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(alignment: Alignment.center, children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // SizedBox(
                  //   height: 250,
                  // ),
                  Text(
                    'Recieved all the truck? Start Rail Route?',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      //showSnackBar(context);
                      setState(() {
                        isApiCallProcess = true;
                      });
                      TrainStatusRequestModel trainStatusRequestModel =
                          TrainStatusRequestModel(trainStatus: true);
                      TrainLocationRequestModel trainLocationRequestModel =
                          TrainLocationRequestModel(
                              trainCurrentLat: "24.09677337101953",
                              trainCurrentLong: "81.77540774437333");

                      BackendInterface.trainStatus(trainStatusRequestModel)
                          .then((Response) async {
                        if (Response.message ==
                            "Train Status Updated Successfully") {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          Get.to(Empty());
                        } else {
                          AlertDialog alert = AlertDialog(
                            title: Text("Error"),
                            content: Text("Error from server side"),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {},
                              ),
                            ],
                          );
                        }
                      });

                      BackendInterface.trainLocation(trainLocationRequestModel)
                          .then((Response) async {
                        if (Response.message ==
                            "Train Status Updated Successfully") {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          Get.off(Empty());
                        } else {
                          AlertDialog alert = AlertDialog(
                            title: Text("Error"),
                            content: Text("Error from server side"),
                            actions: [
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {},
                              ),
                            ],
                          );
                        }
                      });
                    },
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  // Text(
                  //   'Upcoming Trips',
                  //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: item.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     return promoCard('assets/images/fakeMap.jpg', 0, 25, "25 Sept");
                  //   },
                  // ),
                ]),
            if (isApiCallProcess)
              Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Loading(),
                ),
              )
          ]),
        ),
      ),
    );
  }

  Widget promoCard(image, index, orderId, date) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        ExpansionTile(
          collapsedShape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          title: Text("Title"),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text("Vehicle no.: UP53BY6532"),
              Switch(
                // thumb color (round icon)
                activeColor: dark,
                activeTrackColor: Colors.grey,
                inactiveThumbColor: Colors.blueGrey.shade600,
                inactiveTrackColor: Colors.grey.shade400,
                splashRadius: 50.0,
                // boolean variable value
                value: isChecked,
                // changes the state of the switch
                // onChanged: (value) =>
                //     setState(() => isMineOfficial = !isMineOfficial),

                onChanged: (value) {
                  setState(() => isChecked = !isChecked);
                },
              ),
            ]),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
