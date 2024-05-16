import 'package:doctor_c/controller/patient/home_controller.dart';
import 'package:doctor_c/firebase_api/apis.dart';
import 'package:doctor_c/model/doctor.dart';
import 'package:doctor_c/model/specialty.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:doctor_c/style/textStyle.dart';
import 'package:doctor_c/view/widgets/patient/header_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/patient/doctor_widget.dart';
import '../../widgets/patient/specialty_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (controller) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // start Header Home Screen
            HedaerHomeScreen(context, controller),
            // end Header Home Screen
            controller.isSearch == false
                ? Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const Text(
                          'Specialties',
                          style: textTheme.booldTextBlack,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder(
                            stream: controller.getData(Apis.specialtiesDb),
                            builder: (context, snapshot) {
                              print(snapshot.hasData);
                              if (snapshot.hasData) {
                                controller.specialties = snapshot.data!.docs
                                    .map<Specialty>(
                                        (e) => Specialty.fromJson(e.data()))
                                    .toList();
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 100,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 10,
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) {
                                      return InkWell(
                                        onTap: () => controller
                                            .goToDoctorSpecialtyScreen(
                                                controller.specialties,
                                                controller
                                                    .specialties[index].name),
                                        child: SpecialtyWidget(
                                            controller.specialties[index]),
                                      );
                                    }),
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ColorTheme.primary,
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Doctors',
                          style: textTheme.booldTextBlack,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder(
                            stream: controller.getData(Apis.doctorsDb),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                controller.doctors = snapshot.data!.docs
                                    .map((e) => Doctor.fromJson(e.data()))
                                    .toList();
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 10,
                                      );
                                    },
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: ((context, index) => InkWell(
                                          onTap: () => controller
                                              .goToDoctorDetailsFromHome(index),
                                          child: DoctorWidget(context,
                                              controller.doctors[index]),
                                        )),
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: ColorTheme.primary,
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                : StreamBuilder(
                    stream: controller.searchDoctor(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        controller.doctorsSearch = snapshot.data!.docs
                            .map<Doctor>((e) => Doctor.fromJson(e.data()))
                            .toList();

                        return Container(
                          padding: const EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) => Card(
                                  shape: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onTap: () {
                                      controller
                                          .goToDoctorDetailsFromSearch(index);
                                    },
                                    child: ListTile(
                                      leading: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(snapshot
                                                    .data
                                                    .docs[index]['photo']))),
                                      ),
                                      title: Text(
                                        'Dr.${snapshot.data.docs[index]['firstName']}',
                                        style: textTheme.booldTextBlack,
                                      ),
                                      subtitle: Text(
                                        snapshot.data.docs[index]['specialty'],
                                        style: textTheme.greyText,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                          color: ColorTheme.primary,
                        ),
                      );
                    }),
          ],
        ),
      ),
    ));
  }
}
