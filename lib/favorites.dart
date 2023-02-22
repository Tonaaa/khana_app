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
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                leading: const Icon(Icons.list),
                trailing: const Icon(Icons.favorite),
                title: Text("Recipe No $index "));
          }),
    );
  }
}
