import 'package:coal_tracking_app/controllers/login_controller.dart';
import 'package:coal_tracking_app/utils/constants.dart';
import 'package:coal_tracking_app/views/navigation_container.dart';
import 'package:coal_tracking_app/views/widgets/my_button.dart';
import 'package:coal_tracking_app/views/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApiCallProcess = false;
  // text editing controllers
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String email = "";
  String password = "";
  final AuthController authController = Get.find();
  bool isMineOfficial = false;
  final _storage = const FlutterSecureStorage();
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
                const Text("Driver Login"),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: width * 0.04,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                  ),
                ),
                const SizedBox(height: 25),
                // username textField
                MyTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                // password textField
                MyTextField(
                  keyboardType: TextInputType.text,
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
                        'Mine Official? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: GoogleFonts.poppins().fontFamily,
                        ),
                      ),
                      Switch(
                        // thumb color (round icon)
                        activeColor: dark,
                        activeTrackColor: Colors.grey,
                        inactiveThumbColor: Colors.blueGrey.shade600,
                        inactiveTrackColor: Colors.grey.shade400,
                        splashRadius: 50.0,
                        // boolean variable value
                        value: isMineOfficial,
                        // changes the state of the switch
                        // onChanged: (value) =>
                        //     setState(() => isMineOfficial = !isMineOfficial),

                        onChanged: (value) {
                          setState(() => isMineOfficial = !isMineOfficial);
                        },
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
                  onTap: () async {
                    if (!validateAndSave()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill all the fields"),
                        ),
                      );
                      return;
                    }
                    await authController
                        .login(
                      phoneController.text,
                      passwordController.text,
                      isMineOfficial,
                    )
                        .then((value) async {
                      if (value != null) {
                        await _storage.write(
                          key: 'isMineOfficial',
                          value: isMineOfficial.toString(),
                        );
                        await _storage.write(
                          key: 'phone',
                          value: phoneController.text,
                        );
                        await _storage.write(
                          key: 'password',
                          value: passwordController.text,
                        );
                      }
                    });
                    if (authController.authState == AuthState.authenticated) {
                      Get.offAll(
                        () => NavigationContainer(
                          isMineOfficial: isMineOfficial,
                        ),
                      );
                    } else {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid Credentials"),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 50),
                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(
                //           horizontal: 10.0,
                //         ),
                //         child: Text(
                //           'Or',
                //           style: TextStyle(
                //             color: Colors.grey[700],
                //             fontFamily: GoogleFonts.poppins().fontFamily,
                //           ),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 50),
                // google + apple sign in buttons
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     // google button
                //     SquareTile(
                //       imagePath: 'assets/images/google.png',
                //     ),
                //     SizedBox(width: 25),
                //     // apple button
                //     SquareTile(
                //       imagePath: 'assets/images/apple.png',
                //     )
                //   ],
                // ),
                // InkWell(
                //   onTap: () {

                //   },
                //   child: Container(
                //     child: Text(
                //       "Are you mine Official ? Login Here",
                //       style: TextStyle(fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 50,
                ),
                // not a member? register now
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Not a member?',
                //       style: TextStyle(
                //         color: Colors.grey[700],
                //         fontFamily: GoogleFonts.poppins().fontFamily,
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 4,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         //Get.to(Welcome());
                //       },
                //       child: Text(
                //         'Register now',
                //         style: TextStyle(
                //           color: dark,
                //           fontWeight: FontWeight.bold,
                //           decoration: TextDecoration.underline,
                //           fontFamily: GoogleFonts.poppins().fontFamily,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(
                //   height: width * 0.04,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    email = phoneController.text;
    password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }
}
