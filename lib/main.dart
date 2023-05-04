import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:khana_app/dashboard.dart';
import 'package:khana_app/login.dart';
import 'package:khana_app/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:khana_app/screens/category_meals_screen.dart';
import 'package:khana_app/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories.dart';
import 'dummy.dart';
import 'filters.dart';
import 'firebase_options.dart';
import 'models/meal.dart';
import 'screens/meal_detail_screen.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  // add other properties here for the light theme
  canvasColor: Color.fromRGBO(248, 248, 248, 1),
  primarySwatch: Colors.lightGreen,
  appBarTheme: const AppBarTheme(backgroundColor:Colors.lightGreen),
  colorScheme: const ColorScheme.light(),
  accentColor: Colors.lightGreen,
  fontFamily: 'Raleway',
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  // add other properties here for the dark theme
  primarySwatch: Colors.lightGreen,
  colorScheme: const ColorScheme.dark(),
  accentColor: Colors.lightGreen,
  canvasColor: Color.fromRGBO(40, 39, 39, 1),
  fontFamily: 'Raleway',
);
bool isDarkMode = true;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool darkMode = prefs.getBool('darkMode') ?? false;
  isDarkMode = darkMode;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
    // DevicePreview(
    //   enabled: kReleaseMode,
    //   builder: (context) => const MyApp(),
    // ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      // add device preview
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Khana',
      theme: isDarkMode ? darkTheme : lightTheme,

      // direct the main page to the starting page.
      // home: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (!snapshot.hasData) {
      //       return const Splash();
      //     } else if (snapshot.data == null) {
      //       return Register();
      //     } else if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.lightGreenAccent,
      //         ),
      //       );
      //     } else if (snapshot.hasError) {
      //       return const SnackBar(
      //         content: Text('Something went wrong'),
      //       );
      //     } else {
      //       return const Dashboard();
      //     }
      //   },
      // ),
      initialRoute: '',
      routes: {
        '/': (ctx) => Register(),
        '/category-meals': (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailsScreen.routeName: (ctx) =>
            MealDetailsScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        print('onGenerate');
        return MaterialPageRoute(builder: (ctx) => Categories()
            // StreamBuilder<User?>(
            //     stream: FirebaseAuth.instance.authStateChanges(),
            //     builder: (context, snapshot) {
            //       if (!snapshot.hasData) {
            //         print('here');
            //         return Categories();
            //       } else if (snapshot.data == null) {
            //         print('instead');
            //         return Register();
            //       } else if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const Center(
            //           child: CircularProgressIndicator(
            //             color: Colors.lightGreenAccent,
            //           ),
            //         );
            //       } else if (snapshot.hasError) {
            //         return const SnackBar(
            //           content: Text('Something went wrong'),
            //         );
            //       } else {
            //         print('object');
            //         return Register();
            //       }
            //     },
            //   ),
            );
      },
      onUnknownRoute: (settings) {
        print('unknown route');
        return MaterialPageRoute(builder: (ctx) => Splash());
      },
    );
  }
}