import 'package:flutter/material.dart';
import 'package:meals/components/mainDrawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categoryScreen.dart';
import 'package:meals/screens/favoriteScreen.dart';

class TabScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabScreen(this.favoriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    this._screens = [
      {
        'title': 'Lista de Categorias',
        'screen': CategoryScreen(),
      },
      {
        'title': 'Meus Favoritos',
        'screen': FavoriteScreen(widget.favoriteMeals),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      this._selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[this._selectedScreenIndex]['title'],
        ),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: _screens[this._selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: this._selectedScreenIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categorias'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favoritas'),
          ),
        ],
      ),
    );
  }
}
