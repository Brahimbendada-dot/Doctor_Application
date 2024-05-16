import 'package:doctor_c/controller/patient/appointment_controller.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/patient/appointment_widget.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppointmentController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
            child: GetBuilder<AppointmentController>(
          builder: (controller) => StreamBuilder(
            stream: controller.getAppointements(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                controller.appointments = snapshot.data.docs
                    .map<AppointmentModel>(
                        (e) => AppointmentModel.fromJson(e.data()))
                    .toList();
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.appointments.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          controller
                              .cancelAppointment(snapshot.data.docs[index].id);
                        },
                        child: appointmentWidget(
                            snapshot.data.docs[index].id,
                            context,
                            controller.appointments[index],
                            controller.getDoctorById(
                                controller.appointments[index].doctorId)!),
                      );
                    });
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorTheme.primary,
                ),
              );
            },
          ),
        )),
      ),
    );
  }
}
