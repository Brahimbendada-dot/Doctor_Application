import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/doctor.dart';
import '../../view/screens/doctor/profile_details.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Doctor doctor = Doctor(
      id: ' ',
      photo:
          'https://firebasestorage.googleapis.com/v0/b/doctor-307f5.appspot.com/o/profile%2Fprofile.jpg?alt=media&token=b360820d-8a84-4efc-8769-ca2fa03a1ac0',
      dateCreatAccount: DateTime.now(),
      email: ' ',
      address: ' ',
      phone: ' ',
      token: ' ',
      specialty: ' ',
      about: '',
      firstName: '',
      lastName: '');

  SignOut() {
    Get.deleteAll();
    Apis.auth.signOut();
  }

  goToProfileDetails() {
    Get.to(() => const ProfileDetails(), arguments: {
      'doctor': doctor,
    });
  }

  getCurrentDoctorAuthenticate() async {
    DocumentSnapshot snapshot =
        await Apis.doctorsDb.doc(Apis.auth.currentUser!.uid).get();
    doctor = Doctor.fromJson(snapshot.data());
    update();
  }

  @override
  onInit() {
    getCurrentDoctorAuthenticate();
    super.onInit();
  }
}
