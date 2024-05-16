import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:get/get.dart';

class BookAppointmentController extends GetxController {
  late Doctor doctor;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doctor = Get.arguments['doctor'];
  }

  bookApointment(AppointmentModel appointment){
    Apis.appointmentsDb.add(appointment.toJson());
  }
}
