import 'package:flutter/material.dart';
import 'package:meals/screens/category_meals_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/tabs_screen.dart';

import 'models/meal.dart';
import 'screens/categories_screen.dart';
import './dummy_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _avalableMeals = DUMMY_MEALS;
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState((){
      _filters = filterData;
      _avalableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }
        if(_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }
        if(_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        if(_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }
  
  void _toggleFavorite(String mealId) {
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if(existingIndex >= 0 ) {
      setState((){
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.pink,
              secondary: Colors.amber,
          ),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
              subtitle1: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeMame: (ctx) => CategoryMealsScreen(_avalableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
