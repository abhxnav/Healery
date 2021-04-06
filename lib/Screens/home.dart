import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:healery/Widgets/feed_screen.dart';
import 'package:healery/Widgets/post_screen.dart';
import 'package:healery/Widgets/profile_screen.dart';
import 'package:healery/Widgets/search_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItemPosition = 0;
  List<Widget> screens = [
    FeedScreen(),
    PostScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedItemPosition],
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        backgroundColor: Theme.of(context).accentColor,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.fromLTRB(12, 5, 12, 12),
        snakeViewColor: Theme.of(context).canvasColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).canvasColor,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
        }),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
              ),
              label: 'home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.edit_rounded), label: 'post'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded), label: 'search'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded), label: 'profile')
        ],
      ),
    );
  }
}
