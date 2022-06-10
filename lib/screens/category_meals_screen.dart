import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeMame = '/category-meals';
  final List<Meal> avalableMeals;

  CategoryMealsScreen(this.avalableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  late String categoryTitle;
  late List<Meal> displayedMeals;
  bool _loadedInitData = false;


  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData) {
      final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
      categoryTitle = routeArgs['title'];
      final String categoryId = routeArgs['id'];
      displayedMeals = widget.avalableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              displayedMeals[index].id,
              categoryTitle,
              displayedMeals[index].imageUrl,
              displayedMeals[index].duration,
              displayedMeals[index].complexity,
              displayedMeals[index].affordability,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
