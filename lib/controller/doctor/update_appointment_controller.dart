
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/appointment.dart';
import 'package:doctor_c/model/patient.dart';
import 'package:get/get.dart';

class UpdateAppointmentController extends GetxController {
  late Patient patient;
  late String id;
  getDeviceToken() async {
    String? token = await Apis.messaging.getToken();
    return token;
  }

  updateAppointment(AppointmentModel appointment) async {
    
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    patient = Get.arguments['patient'];
    id = Get.arguments['id'];
  }
}
