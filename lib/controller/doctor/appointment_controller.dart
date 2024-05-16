import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/patient.dart';
import '../../view/screens/doctor/update_appointment.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointmentController extends GetxController {
  List<AppointmentModel> appointments = [];
  List<Patient> patients = [];

  Future<String> getDeviceToken() async {
    String? token = await Apis.messaging.getToken();
    return token!;
  }

  sendNotification(
      {required String patientToken,
      required String title,
      required String content}) {
    getDeviceToken().then((value) async {
      var data = {
        'to': patientToken,
        'priority': 'high',
        'notification': {
          'title': title,
          'body': content,
        }
      };
      var response = await http.post(
          Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'key=${Apis.KeyApi}'
          });
      print(response.statusCode);
    });
  }

  goToUpdateAppointment(
      Patient patient, AppointmentModel appointment, String id) {
    Get.to(() => UpdateAppointmentScreen(), arguments: {
      'patient': patient,
      'id': id,
    });
  }

  getAppointements() {
    return Apis.appointmentsDb
        .orderBy('dateTime')
        .where('doctorId', isEqualTo: Apis.currentAuthenticateuser.uid)
        .snapshots();
  }

  getPatients() async {
    QuerySnapshot snapshot = await Apis.patientsDb.get();
    patients = snapshot.docs.map((e) => Patient.fromJson(e.data())).toList();
    update();
  }

  Patient? getPatientById(String id) {
    for (int i = 0; i < patients.length; i++) {
      if (id == patients[i].id) {
        return patients[i];
      }
    }
    return null;
  }

  cancelAppointment(String id) async {
    await Apis.appointmentsDb.doc(id).delete();
  }

  updateAppointment(String id) async {
    // await Apis.appointmentsDb.doc(id).update({});
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPatients();
  }
}
