import 'package:flutter/material.dart';

class AppNavigator {
  static push(BuildContext context, Widget destination) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

  static pushR(BuildContext context, Widget destination) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => destination,
        ));
  }

  static pop(BuildContext context) {
    Navigator.pop(
      context,
    );
  }
}
