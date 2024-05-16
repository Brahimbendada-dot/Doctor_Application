import 'package:doctor_c/controller/patient/auth_controller/login_patient_controller.dart';
import 'package:doctor_c/controller/patient/auth_controller/create_account_patient_controller.dart';
import 'package:doctor_c/functions/validation.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:doctor_c/view/widgets/patient/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/doctor/input_password.dart';

class CreateAccountPatient extends StatelessWidget {
  const CreateAccountPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: GetBuilder<CreateAccountPatientController>(
          init: CreateAccountPatientController(),
          builder: (controller) => Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/logo.jpg'))),
                    ),
                  ),
                  InputField(
                      context,
                      controller.firstName_controller,
                      "Enter First Name",
                      Icons.person,
                      (val) => validation(val, 'user_name'),
                      TextInputType.text),
                  InputField(
                      context,
                      controller.lastName_controller,
                      "Enter Last Name",
                      Icons.person,
                      (val) => validation(val, 'user_name'),
                      TextInputType.text),
                  InputField(
                      context,
                      controller.email_controller,
                      "Enter Email",
                      Icons.email,
                      (val) => validation(val, 'email'),
                      TextInputType.text),
                  GetBuilder<LogInPatientController>(
                    init: LogInPatientController(),
                    builder: (_logInController) => InputPassword(
                        context,
                        controller.firstPassword_controller,
                        "Enter Password",
                        Icons.lock,
                        (val) => validation(val, 'password'),
                        _logInController.obscureText,
                        _logInController.hidden_visible_eye,
                        () => _logInController.show_hidde_Password()),
                  ),
                  GetBuilder<LogInPatientController>(
                    init: LogInPatientController(),
                    builder: (_logInController) => InputPassword(
                        context,
                        controller.secondPassword_controller,
                        "Confirm Your Password",
                        Icons.lock,
                        (val) => validation(val, 'password'),
                        _logInController.obscureText,
                        _logInController.hidden_visible_eye,
                        () => _logInController.show_hidde_Password()),
                  ),
                  InputField(
                      context,
                      controller.phone_controller,
                      "Enter Phone Number",
                      Icons.phone,
                      (val) => validation(val, 'phone'),
                      TextInputType.phone),
                  InputField(
                      context,
                      controller.address_controller,
                      "Enter Addresse",
                      Icons.location_on,
                      (val) => validation(val, 'address'),
                      TextInputType.text),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('You have account ?'),
                      TextButton(
                        child: const Text(
                          'Log In',
                          style: TextStyle(color: ColorTheme.primary),
                        ),
                        onPressed: () => controller.goToLogInPage(),
                      )
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Button('Create Account',
                          () => controller.createAccount(context))),
                  Container(
                    height: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.5);
    path.cubicTo(size.width * 0.25, size.height * 1.5, size.width * 0.75,
        size.height * 0.25, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
