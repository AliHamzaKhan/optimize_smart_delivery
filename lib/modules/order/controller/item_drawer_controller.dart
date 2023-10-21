

import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class ItemDrawerController extends GetxController with GetSingleTickerProviderStateMixin{
  late AnimationController controller;
  late Animation<double> animation;


  initAnimation(){
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  startAnimation(){

  }

  @override
  void onInit() {
    super.onInit();
    initAnimation();
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}