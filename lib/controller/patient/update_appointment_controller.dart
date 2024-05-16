import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:get/get.dart';

class UpdateAppointmentController extends GetxController {
  late Doctor doctor;
  late String id;

  updateAppointment(AppointmentModel appointment) async {
    await Apis.appointmentsDb.doc(id).update(appointment.toJson());
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doctor = Get.arguments['doctor'];
    id = Get.arguments['id'];
  }
}
