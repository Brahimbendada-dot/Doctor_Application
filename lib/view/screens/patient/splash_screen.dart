import 'package:doctor_c/controller/patient/splash_screen_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorTheme.white,
        body: GetBuilder<SplashScreenController>(
          init: SplashScreenController(),
          builder: (controller) => Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash.jpg'))),
            ),
          ),
        ));
  }
}
