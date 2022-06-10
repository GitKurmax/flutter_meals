import 'package:flutter/material.dart';
import 'package:meals/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, void Function() tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
          title,
          style: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
              fontSize: 24
          ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            'Meals',
            Icons.restaurant,
            (){
              Navigator.of(context).pushReplacementNamed('/');
            }
          ),
          buildListTile(
              'Settings',
              Icons.settings,
              (){
                Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
              }
          ),
        ],
      ),
    );
  }
}
