import 'package:flutter/material.dart';
import 'package:khana_app/categories.dart';
import 'package:khana_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten'] ?? false;
    _lactoseFree = widget.currentFilters['lactose'] ?? false;
    _vegetarian = widget.currentFilters['vegetarian'] ?? false;
    _vegan = widget.currentFilters['vegan'] ?? false;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    void Function(bool)? updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white, // changed text color to white
        ),
      ),
      value: currentValue,
      subtitle: Text(description, style: const TextStyle(color: Colors.white)),
      onChanged: updateValue,
      activeColor: Colors.lightGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 40, 40),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Filters'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      //drawer: drawerFunction(context),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Adjust your meal selection.',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
                SwitchListTile(
                  title: const Text(
                    'Mode',
                    style: TextStyle(
                      color: Colors.white, // changed text color to white
                    ),
                  ),
                  activeColor: Colors.lightGreen,
                  value: isDarkMode,
                  subtitle: const Text(
                    'Light or Dark Mode',
                    style: TextStyle(color: Colors.white),
                  ),
                  onChanged: (value) async {
                    setState(() {
                      isDarkMode = value;
                    });

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('darkMode', value);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
