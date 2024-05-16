import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/functions/capitalize_first_letter.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/model/specialty.dart';
import 'package:doctor_c/view/screens/patient/doctor_datails.dart';
import 'package:doctor_c/view/screens/patient/doctor_specialty_screen.dart';
import 'package:doctor_c/view/screens/patient/profil_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  List<Specialty> specialties = [];
  List<Doctor> doctors = [];
  List<Doctor> doctorsSearch = [];
  AppointmentModel? appointment;
  bool isSearch = false;
  late TextEditingController searchController;
  Patient patient = Patient(
      id: ' ',
      firstName: ' ',
      lastName: ' ',
      photo:
          'https://firebasestorage.googleapis.com/v0/b/doctor-307f5.appspot.com/o/profile%2Fprofile.jpg?alt=media&token=b360820d-8a84-4efc-8769-ca2fa03a1ac0',
      dateCreatAccount: DateTime.now(),
      email: 'email',
      address: 'address',
      phone: 'phone',
      token: 'token');

  Future<String> getDeviceToken() async {
    String? token = await Apis.messaging.getToken();
    return token!;
  }

  updateDeviceToken() async {
    getDeviceToken().then((value) {
      Apis.auth.authStateChanges().listen((event) async {
        if (event != null) {
          await Apis.patientsDb
              .doc(Apis.currentAuthenticateuser.uid)
              .update({'token': value});
        }
      });
    });
  }

  checkSearch(String val) {
    if (val == '') {
      isSearch = false;
    }
    update();
  }

  onSearch() {
    isSearch = true;
    update();
  }

  searchDoctor() {
    return Apis.doctorsDb.orderBy('firstName').startAt(
        [capitalizeFirstLetter(searchController.text.toString())]).endAt([
      capitalizeFirstLetter(searchController.text.toString()) + '\uf8ff'
    ]).snapshots();
  }

  Future<void> getCurrentPatientAuthenticate() async {
    Apis.auth.authStateChanges().listen((user) async {
      if (user != null) {
        DocumentSnapshot snapshot =
            await Apis.patientsDb.doc(Apis.auth.currentUser!.uid).get();
        patient = Patient.fromJson(snapshot.data());
        update();
      }
    });
  }

  Stream<QuerySnapshot> getData(CollectionReference collRef) {
    return collRef.snapshots();
  }

  goToDoctorDetailsFromHome(int index) {
    Get.to(() => const DoctorDetails(), arguments: {
      'doctor': doctors[index],
    });
  }

  goToProfileDetails() {
    Get.to(() => const ProfileDetails(), arguments: {'patient': patient});
  }

  goToDoctorSpecialtyScreen(List specialties, String specialtyName) {
    Get.to(() => const DoctorSpecialtyScreen(), arguments: {
      'specialties': specialties,
      'specialty_name': specialtyName,
    });
  }

  goToDoctorDetailsFromSearch(int index) {
    Get.to(() => const DoctorDetails(), arguments: {
      'doctor': doctorsSearch[index],
    });
  }

  @override
  void onInit() async {
    super.onInit();
    searchController = TextEditingController();

    await getCurrentPatientAuthenticate();
    await updateDeviceToken();
    // TODO: implement onInit
  }
}
