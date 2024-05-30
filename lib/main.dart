import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:komiadmin/firebase_options.dart';
import 'package:komiadmin/services/functional/overrides.dart';

import 'services/functional/shared_prefs.dart';
import 'src/app_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPref.init();

  runApp(const AppRoot());
}
