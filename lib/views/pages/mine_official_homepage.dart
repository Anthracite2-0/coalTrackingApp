import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/chat.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/notifications.dart';
import 'package:coal_tracking_app/views/pages/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineOfficialHomepage extends StatefulWidget {
  const MineOfficialHomepage({super.key});

  @override
  State<MineOfficialHomepage> createState() => _MineOfficialHomepageState();
}

class _MineOfficialHomepageState extends State<MineOfficialHomepage> {
  bool isChecked = false;
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
        // title:  Text(
        //   'AppBar',
        //   style: TextStyle(color: Colors.black),
        // ),
        // leading: IconButton(
        //   onPressed: () {},
        //   icon: const Icon(
        //     Icons.menu,
        //     color: Color(0xff161A30),
        //   ),
        // ),
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
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Text(
            'Upcoming Trips',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: item.length,
            itemBuilder: (BuildContext context, int index) {
              return promoCard('assets/images/fakeMap.jpg', 0, 25, "25 Sept");
            },
          ),
        ]),
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
