import 'package:doctor_c/model/doctor.dart';
import '../../view/screens/doctor/edit_profile.dart';
import 'package:get/get.dart';

class ProfileDetailsController extends GetxController {
  late Doctor doctor;

  goToEditProfilePage() {
    Get.to(() => const EditProfile(), arguments: {
      'doctor': doctor,
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    doctor = Get.arguments['doctor'];
  }
}
