
import 'package:doctor_c/controller/doctor/Auth_controller/logIn_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/view/widgets/doctor/button.dart';
import 'package:doctor_c/view/widgets/doctor/input_field.dart';
import 'package:doctor_c/view/widgets/doctor/input_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        child: GetBuilder<LogInController>(
          init: LogInController(),
          builder: (controller) => SingleChildScrollView(
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
                const SizedBox(
                  height: 40,
                ),
                InputField(context, controller.email_controller, "Enter Email",
                    Icons.email, (val)=>null, TextInputType.text),
                InputPassword(
                    context,
                    controller.password_controller,
                    "Enter Password",
                    Icons.lock,
                    (val) =>null,
                    controller.obscureText,
                    controller.hidden_visible_eye, () {
                  controller.show_hidde_Password();
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Dont have account ?'),
                    TextButton(
                      child: const Text(
                        'Create account',
                        style: TextStyle(color: ColorTheme.primary),
                      ),
                      onPressed: () => controller.goToCreatAccountPage(),
                    )
                  ],
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Button(
                        'Log In', () async => await controller.logIn(context)))
              ],
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
