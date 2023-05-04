import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Favorites"),
          backgroundColor: Colors.lightGreen,
        ),
        body: const Center(
          child: Text(
            'No Favorites added yet!',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
