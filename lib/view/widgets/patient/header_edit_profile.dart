import 'package:doctor_c/controller/patient/edit_profile_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


Widget HeaderEditProfile(
    BuildContext context, EditProfileController controller) {
  return Container(
    padding: const EdgeInsets.only(top: 25, left: 8, right: 8),
    width: MediaQuery.of(context).size.width,
    height: 200,
    decoration: const BoxDecoration(
        color: ColorTheme.primary,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(65), bottomRight: Radius.circular(65))),
    child: Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ))
          ],
        ),
        Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: ColorTheme.greyBackGround,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorTheme.white,
                    width: 4,
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(controller.patient.photo),
                  )),
            ),
            Positioned(
              left: 80,
              top: 80,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorTheme.greyBackGround,
                  border: Border.all(width: 4, color: ColorTheme.white),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: ColorTheme.primary,
                  ),
                  onPressed: () {
                    ShowBottomShet(context, controller);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}

ShowBottomShet(context, EditProfileController controller) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: 200,
          color: ColorTheme.primary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chose image :",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const Icon(Icons.camera, color: Colors.white, size: 30),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () async =>
                        await controller.pickImage(ImageSource.camera),
                    child: const Text(
                      "From Camera",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.image, color: Colors.white, size: 30),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () async =>
                        await controller.pickImage(ImageSource.gallery),
                    child: const Text(
                      "From Gallery",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      });
}
