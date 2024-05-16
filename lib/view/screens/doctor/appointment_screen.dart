
import 'package:doctor_c/controller/doctor/appointment_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../model/appointment.dart';
import '../../widgets/doctor/appointment_widget.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppointmentController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SafeArea(
            child: GetBuilder<AppointmentController>(
          builder: (controller) => StreamBuilder(
            stream: controller.getAppointements(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                controller.appointments = snapshot.data.docs
                    .map<AppointmentModel>((e) => AppointmentModel.fromJson(e.data()))
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
                            controller.getPatientById(
                                controller.appointments[index].patientId)!),
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
