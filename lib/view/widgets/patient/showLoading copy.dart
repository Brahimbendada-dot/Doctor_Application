import 'package:doctor_c/style/colors.dart';
import 'package:flutter/material.dart';

showLoading(context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text("Please Wait"),
          content: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: ColorTheme.primary,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        );
      });
}
