import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/view/screens/patient/book_appointment_screen.dart';
import 'package:doctor_c/view/screens/patient/update_appointment.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  List<AppointmentModel> appointments = [];
  List<Doctor> doctors = [];

  // this function return All of Appointment for current user authenticate ,order by date time
  getAppointements() {
    return Apis.appointmentsDb
        .orderBy('dateTime')
        .where('patientId', isEqualTo: Apis.currentAuthenticateuser.uid)
        .snapshots();
  }

  // this function return all of doctors exist and store them in list doctors;
  getDoctors() async {
    QuerySnapshot snapshot = await Apis.doctorsDb.get();
    doctors = snapshot.docs.map((e) => Doctor.fromJson(e.data())).toList();
    update();
  }

  //this function accept argument id and search for doctor by this id in a list doctors and return them
  Doctor? getDoctorById(String id) {
    Doctor? doctor;
    for (int i = 0; i < doctors.length; i++) {
      if (id == doctors[i].id) {
        doctor = doctors[i];
      }
    }
    return doctor;
  }

  // go to appointment Screen for book an appointment
  goToAppintmentScreen(Doctor doctor) {
    Get.to(() => BookAppointmentScreen(), arguments: {
      'doctor': doctor,
    });
  }

// go to update appointment Screen for updated  an appointment
  goToUpdateAppointment(
      Doctor doctor, AppointmentModel appointment, String id) {
    Get.to(() => UpdateAppointmentScreen(), arguments: {
      'doctor': doctor,
      'id': id,
    });
  }

  // this function delete appointment from database;
  cancelAppointment(String id) async {
    await Apis.appointmentsDb.doc(id).delete();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getDoctors();
  }
}
