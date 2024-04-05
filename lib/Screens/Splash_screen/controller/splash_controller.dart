import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Screens/Authentic/pages/authentic_product_page.dart';
import 'package:trapapp_clone/Screens/Authentic/pages/sacn_product_page.dart';

class SplashScreenController extends GetxController with GetSingleTickerProviderStateMixin{

  //! Variable declare
  late AnimationController animatedContainer;
  Animation<double>? animation1;
  var animation;
  var translateTween;

  @override
  void onInit() {
    animatedContainer =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animatedContainer.forward();
    translateTween = Tween<double>(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animatedContainer,
            curve: const Interval(0.0, 0.50, curve: Curves.ease)));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animatedContainer,
        curve:const Interval(0.20, 0.99, curve: Curves.fastOutSlowIn)));
    nextPage();
    super.onInit();
  }

  // Method for going to Next Page
  nextPage() {
    Future.delayed(Duration(seconds: 3), () async {
      // Going to th landing Page
     Get.off(ScanProductPage());
    });
  }

}