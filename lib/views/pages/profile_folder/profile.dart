// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:frontend/controllers/user_controller.dart';
// import 'package:frontend/models/login_response_model.dart';
import 'package:coal_tracking_app/controllers/login_controller.dart';
import 'package:coal_tracking_app/controllers/profile_controller.dart';
import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/pages/profile_folder/profile_list_item.dart';
import 'package:coal_tracking_app/views/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFirst = true;
  final AuthController authController = Get.put(AuthController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    profileController.fetchProfileData('9876567898');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context,
    //     designSize: const Size(896, 414), minTextAdapt: true);
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    // final UserController _userController = Get.put(UserController());
    // _userController.getUserData();

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: width * 0.05,
          color: Colors.blue,
        ),
        Icon(
          LineAwesomeIcons.arrow_left,
          size: width * 0.07,
          color: Colors.white,
        ),
        Expanded(child: SizedBox(width: width * 0.05)),
        // profileInfo,
        Icon(
          LineAwesomeIcons.cog,
          size: width * 0.07,
          color: Colors.white,
        ),

        SizedBox(width: width * 0.05),
      ],
    );

    // return ThemeSwitchingArea(
    return Scaffold(
      backgroundColor: const Color(0xff2B3460),
      body: Obx(
        () {
          final userData = profileController.userData.value;

          if (userData == null) {
            if (profileController.isLoading.value == true) {
              return const Center(child: Loading());
            } else {
              return const Center(child: Text("No data found"));
            }
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width * 0.125,
                    // color: Colors.transparent,
                  ),
                  header,
                  Column(
                    children: <Widget>[
                      Container(
                        height: width * 0.05,
                        width: width * 0.01,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        height: width * 0.4,
                        width: width * 0.4,
                        //margin: EdgeInsets.only(top: width * 3),
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: width * 0.2,
                              backgroundImage:
                                  const AssetImage('assets/images/chicken.png'),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                height: width * 0.10,
                                width: width * 0.10,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  heightFactor: width * 0.2,
                                  widthFactor: width * 0.2,
                                  child: Icon(
                                    LineAwesomeIcons.pen,
                                    color: kDarkPrimaryColor,
                                    size: width * 0.05,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: width * 0.02),
                      Text(
                        userData.fullName, //rempved ${}
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.045,
                        ),
                      ),
                      SizedBox(
                        height: width * 0.025,
                      ),
                      Text(
                        userData.mobile, ////rempved ${}
                        style: TextStyle(
                          // fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                        ),
                      ),
                      SizedBox(
                        height: width * 0.04,
                      ),
                      Container(
                        height: width * 0.12,
                        width: width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 3),
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Text(
                            'Upgrade to PRO',
                            style: TextStyle(
                              // fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: width * 0.05),
                  Column(
                    children: <Widget>[
                      const ProfileListItem(
                        icon: LineAwesomeIcons.user_shield,
                        text: 'Privacy',
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'Purchase History',
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Help & Support',
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Settings',
                      ),
                      const ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Invite a Friend',
                      ),
                      GestureDetector(
                        onTap: () => {
                          authController.logout(),
                        },
                        child: const ProfileListItem(
                          icon: LineAwesomeIcons.alternate_sign_out,
                          text: 'Logout',
                          hasNavigation: false,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
    // var profileInfo = Column(
    //   children: <Widget>[
    //     Container(
    //       height: width * 0.05,
    //       width: width * 0.01,
    //       color: Colors.amber,
    //     ),
    //     Container(
    //       height: width * 0.4,
    //       width: width * 0.4,
    //       //margin: EdgeInsets.only(top: width * 3),
    //       child: Stack(
    //         children: <Widget>[
    //           CircleAvatar(
    //             radius: width * 0.2,
    //             backgroundImage: const AssetImage('images/avatar.png'),
    //           ),
    //           Align(
    //             alignment: Alignment.bottomRight,
    //             child: Container(
    //               height: width * 0.10,
    //               width: width * 0.10,
    //               decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 shape: BoxShape.circle,
    //               ),
    //               child: Center(
    //                 heightFactor: width * 0.2,
    //                 widthFactor: width * 0.2,
    //                 child: Icon(
    //                   LineAwesomeIcons.pen,
    //                   color: kDarkPrimaryColor,
    //                   size: width * 0.05,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     SizedBox(height: width * 0.02),
    //     Text('@${_userController.fullname}',
    //         style: TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.w600,
    //             fontSize: width * 0.045)),
    //     SizedBox(height: width * 0.025),
    //     Text(
    //       '6387242986@paytm',
    //       style: TextStyle(
    //         // fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
    //         fontWeight: FontWeight.w400,
    //         color: Colors.white,
    //       ),
    //     ),
    //     SizedBox(height: width * 0.04),
    //     Container(
    //       height: width * 0.12,
    //       width: width * 0.45,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(width * 3),
    //           color: Colors.white),
    //       child: Center(
    //         child: Text(
    //           'Upgrade to PRO',
    //           style: TextStyle(
    //             // fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
    //             fontWeight: FontWeight.w400,
    //             color: Colors.black,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ],
    // ),
  }
}
