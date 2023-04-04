import 'package:firebase_auth/firebase_auth.dart';
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
        // centerTitle: true,
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
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const CategoryMealsScreen(availableMeals: []),
                      ));
                },
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

  Widget buildListTile(
      String title, IconData icon, void Function() tapHandler) {
    return ListTile(
        leading: Icon(
          icon,
          size: 26,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onTap: tapHandler);
  }

  Widget drawerFunction(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color.fromARGB(240, 0, 0, 0),
        child: Column(children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.lightGreen,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 26,
                  color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Categories(),
                  ));
            },
          ),
          buildListTile('Filters', Icons.settings_outlined, () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FiltersScreen(_filters, _setFilters),
                ));
          }),
        ]),
      ),
    );
  }
}


