import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/controller/patient/doctor_specialty_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/patient/doctor_widget_docspec.dart';
import '../../widgets/patient/doctorspec_search_input.dart';
import '../../widgets/patient/list_of_doctor_specialties.dart';

class DoctorSpecialtyScreen extends StatelessWidget {
  const DoctorSpecialtyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DoctorSpecialtyController>(
        init: DoctorSpecialtyController(),
        builder: (controller) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                DoctorSpecialtySearchInput(context, controller, 1),
                const SizedBox(
                  height: 15,
                ),
                ListOfDoctorSpecialties(controller),
                StreamBuilder(
                    stream: controller.getDoctorWithSpecialty(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        controller.doctors = snapshot.data.docs
                            .map((e) => Doctor.fromJson(e.data()))
                            .toList();
                        return GridView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data.docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 8),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  controller.goToDoctorDetails(index);
                                },
                                child: DoctorSpecWidget(
                                    context, controller.doctors[index]),
                              );
                            });
                      }
                      return const Center(
                          child: CircularProgressIndicator(
                        color: ColorTheme.primary,
                      ));
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
