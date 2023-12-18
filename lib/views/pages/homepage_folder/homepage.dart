// import 'package:coal_tracking_app/current_location.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/chat.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/logs_page.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/notifications.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/pass.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/sos.dart';
import 'package:coal_tracking_app/views/pages/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 235, 235),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xff161A30),
          onPressed: () {
            Get.to(() => const QRScreen());
          },
          label: const Text("Scan the QR"),
          icon: const Icon(Icons.qr_code_scanner_outlined),
        ),
      ),
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Hello, ',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                            TextSpan(
                              text: 'Suresh',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'You are currently ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            TextSpan(
                              text: 'online ',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: 'and heading towards Ghaziabad',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // const Text(
                      //   'You are currently online and heading\ntowards Ghaziabad',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "${DateTime.now().hour.isGreaterThan(12) ? DateTime.now().hour - 12 : DateTime.now().hour == 0 ? 12 : DateTime.now().hour}:${DateTime.now().minute} ${DateTime.now().hour.isGreaterThan(12) ? "PM" : "AM"}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // Container(
                      //   padding: const EdgeInsets.all(5),
                      //   decoration: BoxDecoration(
                      //       color: const Color.fromRGBO(244, 243, 243, 1),
                      //       borderRadius: BorderRadius.circular(15)),
                      //   child: const TextField(
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         prefixIcon: Icon(
                      //           Icons.search,
                      //           color: Colors.black87,
                      //         ),
                      //         hintText: "Search you're looking for",
                      //         hintStyle:
                      //             TextStyle(color: Colors.grey, fontSize: 15)),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 243, 243, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const CurrentLocation(),
                          //   ),
                          // );
                        },
                        child: const Text(
                          "12 km to Ghaz.",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Your Trips',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        promoCard(
                            'assets/images/fakeMap.jpg', 0, 25, "25 Sept"),
                        promoCard(
                            'assets/images/fakeMap(2).jpg', 1, 36, "31 Nov"),
                        promoCard(
                            'assets/images/fakeMap(3).jpg', 2, 56, "6 Sept"),
                        promoCard(
                            'assets/images/fakeMap(2).jpg', 3, 56, "5 Jan"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4),
                          BlendMode.color,
                        ), // Change color here
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/fakeMap.jpg'),
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                stops: const [0.3, 0.9],
                                colors: [
                                  Colors.black.withOpacity(.7),
                                  Colors.black.withOpacity(.3)
                                ],
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 10, bottom: 10),
                                alignment: Alignment.center,
                                height: 40,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.transparent,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const Sos());
                        },
                        child: Container(
                          width: w * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.details_rounded,
                                color: Colors.black,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "SOS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: w * 0.4,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.black,
                              size: 17,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Call",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(const Pass());
                        },
                        child: Container(
                          width: w * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.next_week_rounded,
                                color: Colors.black,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pass",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(LogsPage());
                        },
                        child: Container(
                          width: w * 0.4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.receipt_long_sharp,
                                color: Colors.black,
                                size: 17,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Logs",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // SizedBox(
                  //   height: 100,
                  // )
                  // ignore: prefer_const_constructors
                  SizedBox(
                    //color: Colors.amber,
                    width: 20,
                    height: 200,
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   width: 20,
            //   height: 120,
            // ),
          ],
        ),
      ),
    );
  }

  Widget promoCard(image, index, orderId, date) {
    return AspectRatio(
      aspectRatio: 2.62 / 3,
      child: Container(
        margin: const EdgeInsets.only(right: 15.0),
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color:
                  (index == 0) ? Colors.green.shade400 : Colors.red.shade400),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                //border: Border.all(width: 2, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  stops: const [0.1, 0.9],
                  colors: (index == 0)
                      ? [
                          Colors.black.withOpacity(0),
                          Colors.black.withOpacity(0)
                        ]
                      : [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.5)
                        ],
                ),
              ),
            ),
            (index == 0)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Center(
                          child: SizedBox(
                        height: 4,
                      )),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Order Id: $orderId",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                          child: SizedBox(
                        height: 2,
                      )),
                      Center(
                        child: Text(
                          "Date: $date",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Center(
                          child: SizedBox(
                        height: 4,
                      )),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
