import 'package:coal_tracking_app/views/pages/homepage_folder/chat.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineOfficialHomepage extends StatefulWidget {
  const MineOfficialHomepage({super.key});

  @override
  State<MineOfficialHomepage> createState() => _MineOfficialHomepageState();
}

class _MineOfficialHomepageState extends State<MineOfficialHomepage> {
  @override
  Widget build(BuildContext context) {
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
    );
  }
}
