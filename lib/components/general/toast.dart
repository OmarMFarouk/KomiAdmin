import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class MyToast {
  MyToast(String msg, BuildContext context);

  static customToast(msg, context) {
    return MotionToast(
      icon: Icons.done,
      secondaryColor: Colors.green.shade600,
      primaryColor: const Color(0xFF6C7293),
      backgroundType: BackgroundType.transparent,
      height: kToolbarHeight,
      width: kToolbarHeight * 5.5,
      position: MotionToastPosition.bottom,
      animationType: AnimationType.fromBottom,
      dismissable: true,
      animationDuration: const Duration(milliseconds: 800),
      description: Text(msg),
      toastDuration: const Duration(milliseconds: 1200),
    ).show(context);
  }
}
