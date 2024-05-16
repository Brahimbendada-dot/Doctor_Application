
import 'package:doctor_c/controller/doctor/appointment_controller.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/functions/compare_date_to_today.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget appointmentWidget(
  String id,
  BuildContext context,
  AppointmentModel appointment,
  Patient? patient,
) {
  String status = compareDateToToday(appointment.dateTime);
  Color backgroundColor = ColorTheme.orangeBackground;
  Color textColor = ColorTheme.orange;
  if (appointment.validation) {
    if (status == 'Completed') {
      backgroundColor = ColorTheme.grenBackground;
      textColor = ColorTheme.green;
    }
  } else {
    status = 'Unacceptable';
    backgroundColor = ColorTheme.redBackGround;
    textColor = ColorTheme.red;
  }

  status == 'Completed' ? ColorTheme.green : ColorTheme.orange;
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    height: 180,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(patient!.photo)),
                            color: ColorTheme.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${patient.firstName} ${patient.lastName}', style: textTheme.booldTextBlack),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: backgroundColor),
                      child: Center(
                        child: Text(
                          "${status}",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 45,
                  decoration: BoxDecoration(
                    color: ColorTheme.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: ColorTheme.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${appointment.dateTime.year.toString()}-${appointment.dateTime.month.toString()}-${appointment.dateTime.day.toString()}',
                            style: TextStyle(color: ColorTheme.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.watch_later_outlined,
                            color: ColorTheme.grey,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${(appointment.dateTime.hour + 1).toString()}:00 - ${int.parse(appointment.dateTime.hour.toString()) > 11 ? "PM" : "AM"}',
                            style: TextStyle(color: ColorTheme.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        status == 'Completed'
            ? bookAppointment()
            : GetBuilder<AppointmentController>(
                init: AppointmentController(),
                builder: (controller) => updateAcceptAndReject(
                  update: () {
                    controller.goToUpdateAppointment(patient, appointment, id);
                  },
                  accept: () {
                    controller.sendNotification(
                      patientToken: patient.token,
                      title: 'Appointment Accepted',
                      content:
                          'Your appointment on ${appointment.dateTime} has been accepted',
                    );
                    Apis.appointmentsDb.doc(id).update({
                      'validation': true,
                    });
                    print('succes');
                  },
                  reject: () {
                    controller.sendNotification(
                      patientToken: patient.token,
                      title: 'Appointment Rejected',
                      content:
                          'Your appointment on ${appointment.dateTime} has been Rejected',
                    );
                    controller.cancelAppointment(id);
                  },
                ),
              )
      ],
    ),
  );
}

Widget updateAcceptAndReject(
    {required Function()? update,
    required Function()? reject,
    required Function()? accept}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Button('Reject', reject),
      Button('Accept', accept),
      Button("Update", update),
    ],
  );
}

Widget bookAppointment() {
  return GetBuilder<AppointmentController>(
    init: AppointmentController(),
    builder: (controller) => Button("Book new Appointment", () {}),
  );
}
