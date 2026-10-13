import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDi();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const BaitulHikmaApp(),
    ),
  );
}
