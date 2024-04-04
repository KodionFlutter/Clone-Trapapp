import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trapapp_clone/Screens/Splash_screen/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({Key? key}) : super(key: key);
  final splashController = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: AnimatedBuilder(
            animation: splashController.animatedContainer,
            builder: (context, child) {
              return Center(
                child: Transform(
                    transform: Matrix4.identity()
                      ..translate(0.0, splashController.translateTween.value, 0.0),
                    alignment: Alignment.center,
                    child: ScaleTransition(
                        scale: splashController.animation,
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/newlogo.png",
                          height: 200,
                        ))),
              );
            }));
  }
}
