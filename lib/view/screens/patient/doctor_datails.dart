import 'package:doctor_c/controller/patient/doctor_details_controller.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../widgets/patient/header_doctor_details.dart';

class DoctorDetails extends StatelessWidget {
  const DoctorDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DoctorDetailsController>(
        init: DoctorDetailsController(),
        builder: (controller) => Column(
          children: [
            Expanded(flex: 2, child: HeaderDoctorDetails(context, controller)),
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'About',
                        style: textTheme.booldTextBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: Container(
                          child: Text(controller.doctor.about),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Address",
                        style: textTheme.booldTextBlack,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(controller.doctor.address)
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: Center(
                    child: Button('Book an Appointment',
                        () => controller.goToBookAppointmentPage())))
          ],
        ),
      ),
    );
  }
}
