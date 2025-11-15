import 'package:fire_chat/core/constants/colors.dart';
import 'package:fire_chat/core/constants/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.buttonText, this.onPressed, this.loading = false});

  final void Function()? onPressed;
  final String buttonText;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 40.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: primary),
          onPressed: onPressed,
          child: loading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Text(buttonText, style: body.copyWith(color: white))),
    );
  }
}