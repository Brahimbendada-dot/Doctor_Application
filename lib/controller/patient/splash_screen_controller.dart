import 'package:doctor_c/view/screens/chose_user.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(const ChoseUser());
  }
}
