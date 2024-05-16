import 'package:doctor_c/view/screens/doctor/doctor_app.dart';
import 'package:doctor_c/view/screens/patient/patient_app.dart';
import 'package:get/get.dart';

class ChoseUserController extends GetxController {
  goToDoctorApplication() {
    Get.to(const DoctorApp());
  }
  goToPatientApplication() {
    Get.to(const PatientApp());
  }
}
