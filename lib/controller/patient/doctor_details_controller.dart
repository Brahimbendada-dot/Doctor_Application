import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/view/screens/patient/book_appointment_screen.dart';
import 'package:doctor_c/view/screens/patient/conversation_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class DoctorDetailsController extends GetxController {
  late Doctor doctor;
  callDoctor() async {
    await FlutterPhoneDirectCaller.callNumber(doctor.phone);
  }

  goToConversationScreen() {
    Get.to(() => const ConversationScreen(), arguments: {
      'doctor': doctor,
    });
    Get.delete<DoctorDetailsController>();
  }

  goToBookAppointmentPage() {
    Get.to(() => BookAppointmentScreen(), arguments: {'doctor': doctor});
  }

  @override
  void onInit() {
    // TODO: implement onInit
    doctor = Get.arguments['doctor'];
    super.onInit();
  }
}
