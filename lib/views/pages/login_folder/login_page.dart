import 'dart:convert';

// import 'package:coal_tracking_app/current_location.dart';
import 'package:coal_tracking_app/views/navigation_container.dart';
import 'package:coal_tracking_app/views/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:coal_tracking_app/interface/backend_interface.dart';
// import 'package:frontend/models/login_request_model.dart';
// import 'package:frontend/models/login_response_model.dart';
// import 'package:frontend/navigation_container.dart';
import 'package:coal_tracking_app/utils/constants.dart';
// import 'package:frontend/views/pages/homepage.dart';
// import 'package:frontend/views/pages/onboarding_folder/register.dart';
// import 'package:frontend/views/pages/onboarding_folder/welcome.dart';

import 'package:coal_tracking_app/views/widgets/loading.dart';

import 'package:coal_tracking_app/views/widgets/my_button.dart';
import 'package:coal_tracking_app/views/widgets/my_textfield.dart';
import 'package:coal_tracking_app/views/widgets/square_tile.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String email = "";
  String password = "";

  final storage = new FlutterSecureStorage();

  // sign user in method

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                  color: dark,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: width * 0.04,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // sign in button
                MyButton(
                  h: height * 0.065,
                  w: width * 0.9,
                  text: "Sign in",
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                NavigationContainer()),
                        (route) => false);
                  },
                ),

                const SizedBox(height: 50),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // google button
                    SquareTile(imagePath: 'assets/images/google.png'),

                    SizedBox(width: 25),

                    // apple button
                    SquareTile(imagePath: 'assets/images/apple.png')
                  ],
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        //Get.to(Welcome());
                      },
                      child: Text(
                        'Register now',
                        style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: width * 0.04,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    email = emailController.text;
    password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      print("fuck");
      return false;
    }
    return true;
  }
}
