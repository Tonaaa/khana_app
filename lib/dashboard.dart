import 'package:flutter/material.dart';
import 'categories.dart';
import 'favorites.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var _currentPage = 0;

// ignore: prefer_final_fields
  var _pages = [
    const Categories(),
    Favorites(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: _pages.elementAt(_currentPage)),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.lightGreen,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
            ],
            currentIndex: _currentPage,
            fixedColor: Colors.white,
            onTap: (int inIndex) {
              setState(() {
                _currentPage = inIndex;
              });
            }),
      ),
    );
  }
}
