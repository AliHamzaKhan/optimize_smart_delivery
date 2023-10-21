import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optimize_smart_delivery/modules/registry/controller/registry_controller.dart';
import '../../../Widget/custome_text_field.dart';
import '../../../Widget/app_button.dart';
import '../../../config/helper/my_utils.dart';
import '../../../config/theme/app_colors.dart';

class LoginView extends GetView<RegistryController> {
  LoginView({Key? key}) : super(key: key);
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

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: AppTextField(
                            hintText: "Username",
                            cntrlr: TextEditingController(
                                text: controller.loginData['username']),
                            ispasswordfield: false,
                            isPassword: false,
                            isEmail: false,
                            onChange: (value) {
                              controller.loginData['username'] = value;
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
                          height: screenHeight * 0.04,
                        ),
                        AppButton(
                            title: "SIGN IN",
                            onTap: () async {
                              if (formkey.currentState!.validate()) {
                                if(controller.loginData.isNotEmpty){
                                  await controller.login(
                                    save: controller.isSwitchOn.value,
                                  );
                                }

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
