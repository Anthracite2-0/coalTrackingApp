import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:coal_tracking_app/interface/backend_interface.dart';
import 'package:coal_tracking_app/models/send_coordinates_reqeust_model.dart';
import 'package:coal_tracking_app/models/send_coordinates_resposne_model.dart';
import 'package:coal_tracking_app/views/pages/empty.dart';
import 'package:coal_tracking_app/views/pages/homepage_folder/homepage.dart';
import 'package:coal_tracking_app/views/pages/profile_folder/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:frontend/views/pages/details_screen.dart';
// import 'package:frontend/views/pages/expense_folder/expense_manager.dart';
// import 'package:frontend/views/pages/explore_folder/explore.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:frontend/views/pages/onboarding_folder/age.dart';
// import 'package:frontend/views/pages/onboarding_folder/details.dart';

// import 'package:coal_tracking_app/views/pages/profile_folder/profile_page.dart';
// import 'package:frontend/views/pages/expense_folder/statistics.dart';
// import 'package:frontend/views/pages/splash_screen.dart';

class NavigationContainer extends StatefulWidget {
  const NavigationContainer({super.key});

  @override
  State<NavigationContainer> createState() => _NavigationContainerState();
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  final log = preferences.getStringList('log') ?? <String>[];
  log.add(DateTime.now().toIso8601String());
  await preferences.setStringList('log', log);

  return true;
}

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

Future<void> sendCoordinates(String lat, String long) async {
  SendCoordinatesRequestModel sendCoordinatesRequestModel =
      SendCoordinatesRequestModel(
    currentLat: lat,
    currentLong: long,
  );
  SendCoordinatesResponseModel sendCoordinatesResponseModel =
      await BackendInterface.sendCoordinates(sendCoordinatesRequestModel, "10");
  // print(x);

  return;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString("hello", "world");

  /// OPTIONAL when use custom notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        /// OPTIONAL for use custom notification
        /// the notification id must be equals with AndroidConfiguration when you call configure() method.
        flutterLocalNotificationsPlugin.show(
          888,
          'COOL SERVICE',
          'Awesome ${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'location_logs',
              'LOCATION LOG SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );

        // if you don't using custom notification, uncomment this
        service.setForegroundNotificationInfo(
          title: "My App Service",
          content: "Updated at ${DateTime.now()}",
        );
      }
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    await _determinePosition().then((value) {
      print("Current Location: ${value.latitude} ${value.longitude}");
      sendCoordinates(
        value.latitude.toString(),
        value.longitude.toString(),
      );
    });
    // test using external plugin
    // final deviceInfo = DeviceInfoPlugin();
    // String? device;
    // if (Platform.isAndroid) {
    //   final androidInfo = await deviceInfo.androidInfo;
    //   print('Running on ${androidInfo.id}');
    //   device = androidInfo.model;
    // }
    //
    // if (Platform.isIOS) {
    //   final iosInfo = await deviceInfo.iosInfo;
    //   device = iosInfo.model;
    // }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        // "device": device,
      },
    );
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  /// OPTIONAL, using custom notification channel id
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'location_logs', // id
    'LOCATION LOG SERVICE', // title
    description: 'This channel is used for Location logging.', // description
    importance: Importance.high, // importance must be at low or higher level
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,

      notificationChannelId: 'location_logs',
      initialNotificationTitle: 'AWESOME SERVICE',
      initialNotificationContent: 'Initializing',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

class _NavigationContainerState extends State<NavigationContainer> {
  var currentIndex = 0;

  @override
  void initState() {
    _determinePosition().then((value) => initializeService());

    super.initState();
  }

  List screen = [const HomePage(), const Empty(), const Profile()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: (currentIndex == 0 || currentIndex == 1)
        //     ? Colors.grey.shade300
        //     : const Color(0xff2B3460),
        // backgroundColor: Colors.transparent,
        body: screen[currentIndex],
        extendBody: true,
        bottomNavigationBar: Container(
          padding: EdgeInsets.all((MediaQuery.of(context).size.width > 720
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width) *
              0.03),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
                // top: Radius.circular(40),
                ),
            child: Container(
              alignment: Alignment.center,
              // margin: const EdgeInsets.all(18),
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              height: size.width * .155,
              decoration: BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(.5),
                //     blurRadius: 0,
                //     offset: const Offset(0, 1),
                //     spreadRadius: 1,
                //   ),
                // ],
                borderRadius: BorderRadius.circular(50),
              ),
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  width: 35,
                ),
                shrinkWrap: true,
                itemCount: 3,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 1500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        margin: EdgeInsets.only(
                          bottom: index == currentIndex ? 0 : size.width * .029,
                          right: size.width * .0422,
                          left: size.width * .0422,
                        ),
                        width: size.width * .128,
                        height: index == currentIndex ? size.width * .014 : 0,
                        decoration: const BoxDecoration(
                          color: Color(0xff161A30),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(10),
                          ),
                        ),
                      ),
                      Icon(
                        listOfIcons[index],
                        size: size.width * .076,
                        color: index == currentIndex
                            ? Color(0xff161A30)
                            : Colors.black38,
                      ),
                      SizedBox(height: size.width * .03),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.location_on_rounded,
    // Icons.assured_workload_outlined,
    Icons.person_rounded,
  ];
}
