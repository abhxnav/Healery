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
        backgroundColor: Theme.of(context).canvasColor,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
        snakeViewColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).canvasColor,
        unselectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
        }),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 35.0),
              label: 'home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.post_add_outlined, size: 35.0),
              label: 'post'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded, size: 35.0),
              label: 'search'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined, size: 35.0),
              label: 'profile')
        ],
      ),
    );
  }
}
