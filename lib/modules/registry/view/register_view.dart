

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import '../../../Widget/custome_text_field.dart';
import '../../../Widget/app_button.dart';
import '../../../config/helper/my_utils.dart';
import '../../../config/theme/app_colors.dart';
import '../controller/registry_controller.dart';

class RegisterView extends GetView<RegistryController> {
  RegisterView({Key? key}) : super(key: key);

  String dialCodeDigits = "";
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.appbackgroundColor,
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          color: Colors.transparent,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.07,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.11),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                          letterSpacing: 2,
                          color: AppColors.alterColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.025,
                ),
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.11),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign in to continue",
                      style: TextStyle(
                          letterSpacing: 1.5,
                          color: AppColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  // height: screenHeight * 0.44,
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  width: screenWidth * 0.87,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.subBackgroundColor,
                            blurRadius: 50,
                            spreadRadius: 5)
                      ],
                      color: AppColors.subBackgroundColor,
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15))),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        // SizedBox(
                        //   height: screenHeight * 0.009,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 4),
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       CountryCodePicker(
                        //         backgroundColor: appbackgroundColor,
                        //         flagDecoration:
                        //             const BoxDecoration(shape: BoxShape.circle),
                        //         boxDecoration:
                        //             BoxDecoration(color: appbackgroundColor),
                        //         onChanged: (country) {
                        //           setState(() {
                        //             dialCodeDigits =
                        //                 country.dialCode.toString();
                        //           });
                        //         },
                        //         initialSelection: "PK",
                        //         textStyle:
                        //             TextStyle(color: textColor, fontSize: 16),
                        //         dialogTextStyle:
                        //             TextStyle(color: textColor, fontSize: 16),
                        //         showCountryOnly: false,
                        //         showOnlyCountryWhenClosed: false,
                        //         favorite: const [
                        //           "+1",
                        //           "US",
                        //           "+92",
                        //           "PAK",
                        //           "+61",
                        //           "AUS"
                        //         ],
                        //       ),
                        //       Expanded(
                        //         flex: 1,
                        //         child: TextFormField(
                        //           // maxLength: 12,
                        //           validator: (value) {
                        //             if (value!.isEmpty) {
                        //               return "Please Enter Your Number";
                        //             } else {
                        //               return null;
                        //             }
                        //           },
                        //           style: TextStyle(color: textColor),
                        //           cursorColor: textColor,
                        //           textAlign: TextAlign.start,
                        //           keyboardType: TextInputType.number,
                        //           controller: _controller,
                        //           decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintText: "Phone Number",
                        //             hintStyle: TextStyle(color: textColor),
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        // const HorizontelLine(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppTextField(
                            hintText: "Username",
                            cntrlr: TextEditingController(
                                text: controller.loginData['name']),
                            ispasswordfield: false,
                            isPassword: false,
                            isEmail: false,
                            onChange: (value) {
                              controller.loginData['name'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Your username";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const HorizontalLine(),
                        SizedBox(
                          height: screenHeight * 0.005,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppTextField(
                            hintText: "Password",
                            cntrlr: TextEditingController(
                                text: controller.loginData['password']),
                            ispasswordfield: true,
                            isPassword: true,
                            isEmail: false,
                            onChange: (value) {
                              controller.loginData['password'] = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Your Password";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const HorizontalLine(),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FlutterSwitch(
                                  value: controller.isSwitchOn.value,
                                  height: 20.0,
                                  width: 35.0,
                                  activeColor: AppColors.alterColor,

                                  //padding: 4.0,
                                  toggleSize: 15,
                                  borderRadius: 12,
                                  activeToggleColor: Colors.white,
                                  inactiveToggleColor: Colors.white,
                                  onToggle: (val) {
                                    controller.isSwitchOn.value = val;

                                  }),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "remember me",
                                style: TextStyle(color: AppColors.textColor),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.04,
                        ),
                        AppButton(
                            title: "SIGN UP",
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                await controller.login(
                                  save: controller.isSwitchOn.value,
                                );
                              }
                            }),

                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
