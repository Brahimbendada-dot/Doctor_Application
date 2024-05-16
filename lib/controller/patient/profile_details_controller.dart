import 'package:doctor_c/model/patient.dart';
import 'package:doctor_c/view/screens/patient/edit_profile.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  late Patient patient;

  goToEditProfilePage() {
    Get.to(() => const EditProfile(), arguments: {
      'patient': patient,
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    patient = Get.arguments['patient'];
  }
}
