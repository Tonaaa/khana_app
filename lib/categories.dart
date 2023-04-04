import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khana_app/dummy.dart';
import 'package:khana_app/filters.dart';
import 'package:khana_app/model/meal.dart';
import 'package:khana_app/register.dart';

class Categories extends StatefulWidget {
  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Categories"),
        backgroundColor: Colors.lightGreen,
        toolbarHeight: 70,
      ),
      drawer: drawerFunction(context),
      body: Container(
          padding: const EdgeInsets.all(40),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(30),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                onPressed: () {
                  logOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
                child: const Text(
                  'Senegal',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepOrange),
                ),
                child: const Text('Cameroon',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                ),
                child: const Text('Nigeria',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lime),
                ),
                child: const Text('Morocco',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                child: const Text('Rwanda',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal),
                ),
                child: const Text('Ethiopia',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
                child: const Text('Zimbabwe',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                ),
                child: const Text('Mozambique',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                child: const Text('Ghana',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text('Kenya',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {
                },
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.brown),
                ),
                child: const Text('Tanzania',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                ),
                child: const Text('Burkina Faso',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    )),
                onPressed: () {},
              ),
            ],
          )),
    );
  }

  void logOut() {
    FirebaseAuth.instance.signOut();
  }
}


