import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:khana_app/dashboard.dart';
import 'package:khana_app/login.dart';
import 'package:khana_app/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:khana_app/splash.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        // add device preview
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'Registration Page',
        theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            colorScheme: const ColorScheme.dark(),
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                      fontFamily: 'RobotoCondensed',
                      fontSize: 20,
                      color: Colors.white),
                )),
        // direct the main page to the starting page.
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Splash();
            } else if (snapshot.data == null) {
              return Register();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightGreenAccent,
                ),
              );
            } else if (snapshot.hasError) {
              return const SnackBar(
                content: Text('Something went wrong'),
              );
            } else {
              return const Dashboard();
            }
          },
        )

        // FirebaseAuth.instance.currentUser == null
        //     ?  Register()
        //     : const Dashboard(),
        );
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Object>(
//       stream: null,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return const Splash();
//         } else if (snapshot.data == null) {
//           return Register();
//         } else {
//           return const Dashboard();
//         }
//       },
//     );
//   }
// }
