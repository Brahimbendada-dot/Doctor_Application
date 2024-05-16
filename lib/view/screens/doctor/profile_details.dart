import 'package:doctor_c/controller/doctor/profile_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widgets/doctor/button.dart';
import '../../widgets/doctor/container_profile_details.dart';
import '../../widgets/doctor/header_profile_details.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileDetailsController>(
          init: ProfileDetailsController(),
          builder: (controller) => Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HeaderProfileDetails(context, controller),
                      const SizedBox(
                        height: 20,
                      ),
                      ContainerProfileDetails(context, Icons.person,
                          controller.doctor.firstName, 'First Name'),
                      ContainerProfileDetails(context, Icons.person,
                          controller.doctor.lastName, 'Last Name'),
                      ContainerProfileDetails(context, Icons.info,
                          controller.doctor.about, 'About'),
                      ContainerProfileDetails(
                          context,
                          Icons.manage_search_outlined,
                          controller.doctor.specialty,
                          'Specialty'),
                      ContainerProfileDetails(context, Icons.email,
                          controller.doctor.email, 'Email'),
                      ContainerProfileDetails(context, Icons.phone,
                          controller.doctor.phone, 'Phone'),
                      ContainerProfileDetails(context, Icons.location_on,
                          controller.doctor.address, 'Address'),
                      const SizedBox(
                        height: 20,
                      ),
                      Button('Edit Profile',
                          () => controller.goToEditProfilePage()),
                    ],
                  ),
                ),
              )),
    );
  }
}
