import 'package:flutter/material.dart';
import 'package:meals/data/dymmyData.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/setting.dart';
import 'package:meals/screens/settingScreen.dart';
import 'package:meals/screens/tabScreen.dart';

import 'package:meals/utils/appRoute.dart';

import 'package:meals/screens/categoryMealScreen.dart';
import 'package:meals/screens/categoryScreen.dart';
import 'package:meals/screens/mealDetailScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Setting setting = Setting();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Setting setting) {
    setState(() {
      this.setting = setting;

      this._availableMeals = DUMMY_MEALS.where((meal) {
        final filterGluten = setting.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = setting.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = setting.isVegan && !meal.isVegan;
        final filterVegetarian = setting.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      this._favoriteMeals.contains(meal)
          ? this._favoriteMeals.remove(meal)
          : this._favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return this._favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      // home: CategoryScreen(),
      routes: {
        AppRoute.HOME: (ctx) => TabScreen(
              this._favoriteMeals,
            ),
        AppRoute.CATEGORIES_MEALS: (ctx) => CategoryMealScreen(
              this._availableMeals,
            ),
        AppRoute.MEAL_DETAIL: (ctx) => MealDetailScreen(
              this._toggleFavorite,
              this._isFavorite,
            ),
        AppRoute.SETTINGS: (ctx) => SettingScreen(
              this.setting,
              this._filterMeals,
            ),
      },

      onGenerateRoute: (settings) {
        if (settings.name == '/alguma-coisa') {
          return null;
        } else if (settings.name == '/alguma-coisa') {
          return null;
        } else {
          return MaterialPageRoute(
            builder: (_) {
              return CategoryScreen();
            },
          );
        }
      },

      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return CategoryScreen();
          },
        );
      },
    );
  }
}
