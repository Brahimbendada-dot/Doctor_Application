import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/doctor/profile_controller.dart';
import '../../widgets/doctor/button_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) => SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                          color: ColorTheme.greyBackGround,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorTheme.primary,
                            width: 3,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(controller.doctor.photo),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Dr.${controller.doctor.firstName} ${controller.doctor.lastName}",
                            style: textTheme.profileText),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(controller.doctor.email,
                            style: textTheme.profileSubText),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "PROFILE",
                  style: textTheme.capitalText,
                ),
                ButtonProfile(
                    Icons.person,
                    'Profile Details',
                    'View & Edit informations',
                    () => controller.goToProfileDetails()),
                const Text(
                  "SETTINGS",
                  style: textTheme.capitalText,
                ),
                ButtonProfile(
                    Icons.settings, 'Settings', 'Language & Theme Mode', () {}),
                ButtonProfile(Icons.notifications_active, 'Push notification',
                    'View & Edit informations', () {}),
                ButtonProfile(Icons.lock_rounded, 'Privacy policy',
                    'View & Edit informations', () {}),
                const Text(
                  "LOG OUT",
                  style: textTheme.capitalText,
                ),
                ButtonProfile(Icons.person, 'Log Out', 'Deconnexion',
                    () => controller.SignOut()),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
