import 'package:doctor_c/controller/patient/doctor_app_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class PatientApp extends StatelessWidget {
  const PatientApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PatientAppController());
    return GetBuilder<PatientAppController>(
        builder: (_controller) => Scaffold(
              body: _controller.screenPage[_controller.selectedIndex],
              bottomNavigationBar: Container(
                child: GNav(
                  padding: EdgeInsets.all(8),
                  tabBackgroundColor: Colors.white,
                  gap: 3,
                  backgroundColor: ColorTheme.primary,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  activeColor: Colors.indigo[300],
                  color: Colors.white,
                  selectedIndex: _controller.selectedIndex,
                  onTabChange: (val) => _controller.changeScreen(val),
                  style: GnavStyle.google,
                  tabs: const [
                    GButton(
                      margin: EdgeInsets.all(10),
                      text: 'Home',
                      icon: Icons.home_filled,
                      iconColor: ColorTheme.white,
                    ),
                    GButton(
                      text: 'Chat',
                      icon: Icons.chat,
                      iconColor: ColorTheme.white,
                    ),
                    GButton(
                      text: 'Appointment',
                      icon: Icons.calendar_month,
                      iconColor: ColorTheme.white,
                    ),
                    GButton(
                      text: 'Profile',
                      icon: Icons.person_2,
                      iconColor: ColorTheme.white,
                    ),
                  ],
                ),
              ),
            ));
  }
}
