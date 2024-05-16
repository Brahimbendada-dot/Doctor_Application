import 'package:doctor_c/controller/patient/home_controller.dart';
import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

Widget HomeSearchInput(
  BuildContext context,
  HomeScreenController controller,
  double size,
) {
  return Container(
    padding: const EdgeInsets.only(left: 15),
    width: MediaQuery.of(context).size.width * size,
    height: 45,
    decoration: BoxDecoration(
      color: ColorTheme.greyBackGround,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextFormField(
      controller: controller.searchController,
      onChanged: (val) {
        controller.checkSearch(val);
      },
      decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: const TextStyle(color: ColorTheme.grey),
          border: InputBorder.none,
          suffixIcon: IconButton(
            onPressed: () {
              controller.onSearch();
            },
            icon: const Icon(
              Icons.search,
              color: ColorTheme.grey,
            ),
          )),
    ),
  );
}
