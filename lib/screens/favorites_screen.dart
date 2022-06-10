import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;
  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {if (favoriteMeals.isEmpty) {
      return const Center(
          child: Text('You have no favorites yet - start adding some!'));
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            favoriteMeals[index].id,
            favoriteMeals[index].title,
            favoriteMeals[index].imageUrl,
            favoriteMeals[index].duration,
            favoriteMeals[index].complexity,
            favoriteMeals[index].affordability,
          );
        },
          itemCount: favoriteMeals.length,
      );
    }
  }
}
