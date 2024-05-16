import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/view/screens/patient/profil_details.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Patient patient = Patient(
      id: ' ',
      firstName: ' ',
      lastName: ' ',
      photo:
          'https://firebasestorage.googleapis.com/v0/b/doctor-307f5.appspot.com/o/profile%2Fprofile.jpg?alt=media&token=b360820d-8a84-4efc-8769-ca2fa03a1ac0',
      dateCreatAccount: DateTime.now(),
      email: ' ',
      address: ' ',
      phone: ' ',
      token: ' ');

  getPatient() async {
    DocumentSnapshot snapshot =
        await Apis.patientsDb.doc(Apis.auth.currentUser!.uid).get();
    patient = Patient.fromJson(snapshot.data() as Map<String, dynamic>);
    update();
  }

  // ignore: non_constant_identifier_names
  SignOut() {
    Get.deleteAll();
    Apis.auth.signOut();
  }

  goToProfileDetails() {
    Get.to(() => ProfileDetails(), arguments: {
      'patient': patient,
    });
  }

  @override
  onInit() {
    getPatient();
    super.onInit();
  }
}
