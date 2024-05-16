import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static get currentAuthenticateuser => auth.currentUser;
  static CollectionReference specialtiesDb =
      FirebaseFirestore.instance.collection("Specialties");
  static CollectionReference doctorsDb =
      FirebaseFirestore.instance.collection("Doctors");
  static CollectionReference patientsDb =
      FirebaseFirestore.instance.collection("Patients");
  static CollectionReference appointmentsDb =
      FirebaseFirestore.instance.collection('Appointments');
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static const String KeyApi =
      'AAAAlam5DGE:APA91bFUnFrC3OJ0EEVCgPNHnKjF7yc-Ms7flA__2UCGjTRCcXdam6yZQ_7wQKN8R1rD-8p9YyTFQJkJwIKjcI977sOqZ3WbJorKjSNW2WGYR4Dw2YVDaSsqMMT-YVG8HQP4z0yxsEPT';
  static String getConversaitionId(String id) =>
      currentAuthenticateuser.uid.hashCode <= id.hashCode
          ? '${auth.currentUser!.uid}_$id'
          : '${id}_${auth.currentUser!.uid}';
}
