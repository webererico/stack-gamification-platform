import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stack_gamification_platform/app.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const StackUpApp());
}
