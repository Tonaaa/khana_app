import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khana_app/dashboard.dart';
import 'package:khana_app/dummy.dart';
import 'package:khana_app/filters.dart';
import 'package:khana_app/register.dart';
import 'package:khana_app/screens/category_meals_screen.dart';
import 'package:khana_app/splash.dart';
import 'package:khana_app/widgets/category_item.dart';

import 'favorites.dart';
import 'models/meal.dart';

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

  var _currentPage = 0;

// ignore: prefer_final_fields
  var _pages = [
    Categories(),
    Favorites(),
  ];

  String profilePicLink = '';
  PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print('here');
          return Scaffold(
            appBar: AppBar(
              // centerTitle: true,
              title: const Text("Categories"),
              backgroundColor: Colors.lightGreen,
              // toolbarHeight: 70,
              actions: [
                DropdownButton<String>(
                  icon: const Icon(
                    Icons.more_vert_outlined,
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    if (value == 'logout') {
                      // handle logout
                      logOut();
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                  ],
                ),
              ],
            ),
            drawer: drawerFunction(context),
            bottomNavigationBar:
                //Center(child: _pages.elementAt(_currentPage)),
                BottomNavigationBar(
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
                        _pages.elementAt(_currentPage);
                      });
                    }),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(30),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: DUMMY_CATEGORIES
                    .map((catData) =>
                        CategoryItem(catData.id, catData.title, catData.color))
                    .toList(),
              ),
            ),
          );
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
        } else if (snapshot.data == null) {
          print('instead');
          return Register();
        } else if (!snapshot.hasData) {
          print('object');
          return Register();
        }

        return Register();
      },
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
        child: Column(
          children: [
            Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                color: Colors.lightGreen,
                child: GestureDetector(
                  onTap: () {
                    pickUploadImage();
                    // selectPicture();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                        // margin: const EdgeInsets.only(top: 80, bottom: 24),
                        height: 50,
                        width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Center(
                            child: profilePicLink == ''
                                ? const Icon(
                                    Icons.person,
                                    color: Color.fromARGB(255, 214, 214, 214),
                                    size: 20,
                                  )
                                // Image.file(File(pickedFile!.path!))
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(profilePicLink),
                                  )

                            // profilePicLink == " "
                            //     ? const Icon(
                            //         Icons.person,
                            //         color: Color.fromARGB(255, 214, 214, 214),
                            //         size: 20,
                            //       )
                            //     : Image.network(profilePicLink),
                            ),
                      ),
                      Text(
                        FirebaseAuth.instance.currentUser!.email.toString(),
                      ),
                    ],
                  ),
                )
                // const Text(
                //   'Cooking Up!',
                //   style: TextStyle(
                //       fontWeight: FontWeight.w700,
                //       fontSize: 26,
                //       color: Colors.white),
                // ),
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
                      builder: (context) => Categories(),
                    ));
              },
            ),
            buildListTile('Filters', Icons.settings_outlined, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FiltersScreen(_filters, _setFilters),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 300,
      maxHeight: 300,
      imageQuality: 75,
    );

    Reference ref = FirebaseStorage.instance.ref().child("butter.jpg");
    print('ref');

    await ref.putFile(File(image!.path));
    ref.getDownloadURL().then((value) {
      print(value);
      setState(() {
        profilePicLink = value;
      });
    });
  }
  // Future selectPicture() async {
  //   final result = await FilePicker.platform.pickFiles();
  //   print('res');
  //   if (result == null) {
  //     print('whoops');
  //   } else {
  //     setState(() {
  //       print('setstate');
  //       pickedFile = result.files.first;
  //     });
  //   }
  // }

  // void pickUploadImage() async {
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 300,
  //     maxHeight: 300,
  //     imageQuality: 75,
  //   );

  //   if (image != null) {
  //     final file = File(image.path);
  //     // final uri = Uri.file(file.path);

  //     Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");

  //     await ref.putFile(file);
  //     ref.getDownloadURL().then((value) {
  //       print(value);
  //       setState(() {
  //         profilePicLink = value;
  //       });
  //     });
  //   }
  // }
}
