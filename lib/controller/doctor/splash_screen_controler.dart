import '../../view/screens/doctor/doctor_app.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(const DoctorApp());
  }
}
