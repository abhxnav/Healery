import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedItemPosition = 0;

  List<Map> data = [
    {
      'name': ' Tony Stark',
      'postTitle': 'Working on Mark III! What you guys up to?',
      'timestamp': '20 March, 2021',
      'profilePic':
          'https://pbs.twimg.com/profile_images/2753097667/471b1b700c95affe5b8ee7cc37bd11b6_400x400.jpeg',
      'postPic':
          'https://www.freshnessmag.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_570/MTM2ODM2NjQ2MzE4MzE5MTk5/iron-man-3---the-technology-behind-the-mark-42-suit--video---0.webp',
      'likes': 144,
      'comments': 24,
    },
    {
      'name': 'Thor',
      'postTitle': 'Stormbreaker > Mjolnir?',
      'timestamp': '19 March, 2021',
      'profilePic':
          'https://upload.wikimedia.org/wikipedia/en/3/3c/Chris_Hemsworth_as_Thor.jpg',
      'postPic':
          'https://static2.srcdn.com/wordpress/wp-content/uploads/2019/11/Thor-Stormbreaker-Mjolnir.jpg?q=50&fit=crop&w=960&h=500&dpr=1.5',
      'likes': 121,
      'comments': 14,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Healery',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        data[index]['profilePic'],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(data[index]['name']),
                    Spacer(),
                    Text(data[index]['timestamp'],
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data[index]['postTitle'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                SizedBox(height: 10),
                Image.network(
                  data[index]['postPic'],
                  width: double.infinity,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.favorite_rounded, color: Colors.red),
                    SizedBox(width: 5),
                    Text(data[index]['likes'].toString()),
                    SizedBox(width: 30),
                    Icon(Icons.message_rounded),
                    SizedBox(width: 5),
                    Text(data[index]['comments'].toString()),
                  ],
                ),
              ],
            ),
          ),
          shrinkWrap: true,
          itemCount: data.length,
        ),
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.fromLTRB(12, 5, 12, 12),
        snakeViewColor: Theme.of(context).canvasColor,
        selectedItemColor: SnakeShape.circle == SnakeShape.indicator
            ? Theme.of(context).canvasColor
            : null,
        unselectedItemColor: Theme.of(context).canvasColor,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() => _selectedItemPosition = index),
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'home'),
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
