import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:calory/src/common/channels/dart_to_java_channels/login_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../common_widgets/highlighted_rtextfield.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_string.dart';
import '../main_tab/main_tab_view.dart';
import '../signup_screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  bool passToggle = true;
  final formField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: const AssetImage(splashImage),
                  height: size.height * 0.2,
                ),
                const Text(wellBak, style: TextStyle(color: Colors.black)),
                const Text(loginAcc, style: TextStyle(color: Colors.black)),
                Form(
                  key: formField,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HighlightRoundTextField(
                          keyboardType: TextInputType.text,
                          labelText: uName,
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Username";
                            }
                            return null;
                          },
                          prefixIcon: const Icon(Icons.person_outline_outlined,
                              color: darkColor),
                        ),
                        const SizedBox(height: defaultSize),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: passController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          obscureText: passToggle,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            prefixIcon:
                                const Icon(Icons.fingerprint, color: darkColor),
                            labelText: uPassword,
                            labelStyle: const TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              // Adjust the radius as needed
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors.blue), // Color when focused
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              // Adjust the radius as needed
                              borderSide: const BorderSide(
                                  color: Colors
                                      .transparent), // Color when enabled but not focused
                            ),
                            suffix: InkWell(
                              onTap: () {
                                setState(() {
                                  passToggle = !passToggle;
                                });
                              },
                              child: Icon(
                                passToggle
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: loginSpace),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen()),
                                  );
                                },
                                child: const Text(newUse)),
                            TextButton(
                                onPressed: () {}, child: const Text(foPass)),
                          ],
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: accentColor,
                                  foregroundColor: darkColor),
                              onPressed: () async {
                                String name = nameController.text.trim();
                                String password = passController.text.trim();

                                bool isTrue =
                                    await LoginDataChannel.submitLoginData(
                                        name, password);

                                if (formField.currentState!.validate() &&
                                    isTrue) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainTabView()),
                                  );
                                } else {
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.danger,
                                          title: "Oops...",
                                          text:
                                              "Incorrect Username or Password"));
                                }
                                /*if (formField.currentState!.validate() &&
                                    name == "Gokul" &&
                                    password == "Gokul@123") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainTabView()),
                                  );
                                } else if ((name.isNotEmpty &&
                                        password.isNotEmpty) &&
                                    (name != "Gokul" ||
                                        password != "Gokul@123")) {
                                  ArtSweetAlert.show(
                                      context: context,
                                      artDialogArgs: ArtDialogArgs(
                                          type: ArtSweetAlertType.danger,
                                          title: "Oops...",
                                          text:
                                              "Incorrect Username or Password"));
                                }*/
                              },
                              child: Text(
                                login.toUpperCase(),
                                style: const TextStyle(color: whiteColor),
                              ),
                            )),
                        const SizedBox(height: loginSpace),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("OR"),
                            const SizedBox(height: loginSpace),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  icon: const Image(
                                    image: AssetImage(googleIcon),
                                    width: 20.0,
                                  ),
                                  onPressed: () {},
                                  label: const Text(google)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*class LoginDataChannel {
  // nutrients channel
  static const MethodChannel _channel = MethodChannel('login_data_channel');

  static Future<void> submitLoginData(
      String username, String password) async {
    try {
      await _channel.invokeMethod(
          'submitLoginData', {"username": username, "password": password});
    } on PlatformException catch (e) {
      print("Failed to submit form data: '${e.message}'.");
    }
  }
}*/
