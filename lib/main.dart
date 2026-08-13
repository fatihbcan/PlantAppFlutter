import 'package:flutter/material.dart';
import 'package:hubx_flutter_case/app/app.dart';
import 'package:hubx_flutter_case/app/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // The graph resolves SharedPreferences eagerly, so the onboarding guard can
  // read the completion flag synchronously on the very first navigation.
  await configureDependencies();
  runApp(App());
}
