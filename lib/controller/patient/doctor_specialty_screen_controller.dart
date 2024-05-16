import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/view/screens/patient/doctor_datails.dart';
import 'package:get/get.dart';

class DoctorSpecialtyController extends GetxController {
  late List specialties = [];
  List doctors = [];
  late String specialty_name;

  @override
  void onInit() {
    specialties = Get.arguments['specialties'];
    specialty_name = Get.arguments['specialty_name'];
    super.onInit();
  }

  changeSpecialty(String specialty) {
    specialty_name = specialty;
    update();
  }

  goToDoctorDetails(int index) {
    Get.to(() => const DoctorDetails(), arguments: {
      'doctor': doctors[index],
    });
  }

  getDoctorWithSpecialty() {
    return Apis.doctorsDb
        .where('specialty', isEqualTo: specialty_name)
        .snapshots();
  }
}
