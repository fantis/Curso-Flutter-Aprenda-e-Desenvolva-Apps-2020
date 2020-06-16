import 'package:flutter/material.dart';
import 'package:meals/components/mealItem.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';

class CategoryMealScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoryMealScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(
            categoryMeals[index],
          );
        },
      ),
    );
  }
}
