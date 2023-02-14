import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:khana_app/login.dart';

void main() => runApp(
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // add device preview
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Registration Page',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        colorScheme: ColorScheme.dark(),
      ),
      // direct the main page to the starting page
      home: const LoginPage(),
    );
  }
}
