import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:frontend/views/pages/details_screen.dart';
// import 'package:frontend/views/pages/expense_folder/expense_manager.dart';
// import 'package:frontend/views/pages/explore_folder/explore.dart';
import 'package:coal_tracking_app/views/pages/homepage.dart';
// import 'package:frontend/views/pages/onboarding_folder/age.dart';
// import 'package:frontend/views/pages/onboarding_folder/details.dart';

import 'package:coal_tracking_app/views/pages/profile_folder/profile_page.dart';
// import 'package:frontend/views/pages/expense_folder/statistics.dart';
// import 'package:frontend/views/pages/splash_screen.dart';
import 'package:get/get.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

class _NavigationContainerState extends State<NavigationContainer> {
  var currentIndex = 0;

  //

  List Screen = [HomePage(), ProfilePage(), ProfilePage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: (currentIndex == 0 || currentIndex == 1)
          ? Colors.grey.shade300
          : Color(0xff2B3460),
      body: Screen[currentIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(18),
        height: size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: size.width * .024),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(
                () {
                  if (index != currentIndex) {
                    //Get.deleteAll(); //Removes Controller every time we navigate to keep the data in controller up to date with backend .
                  }

                  currentIndex = index;
                },
              );
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  margin: EdgeInsets.only(
                    bottom: index == currentIndex ? 0 : size.width * .029,
                    right: size.width * .0422,
                    left: size.width * .0422,
                  ),
                  width: size.width * .128,
                  height: index == currentIndex ? size.width * .014 : 0,
                  decoration: BoxDecoration(
                    color: Color(0xff2B3467),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                ),
                Icon(
                  listOfIcons[index],
                  size: size.width * .076,
                  color: index == currentIndex
                      ? Color(0xff2B3460)
                      : Colors.black38,
                ),
                SizedBox(height: size.width * .03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.compare_arrows_rounded,
    Icons.assured_workload_outlined,
    Icons.person_rounded,
  ];
}
