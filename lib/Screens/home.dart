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
      'name': 'Albert Camus',
      'postTitle': 'I did it! I got a job!',
      'postText': 'Title says it all:)',
      'timestamp': '21 March, 2021',
      'profilePic':
          'https://s.france24.com/media/display/b5d2f706-0a20-11e9-9cdb-005056bff430/w:1280/p:1x1/camus%20jpg.jpg',
      'likes': 161,
      'comments': 34,
    },
    {
      'name': 'Arthur Schopenhauer',
      'postTitle': 'I need therapy but don’t want to get it',
      'postText':
          'I feel unmotivated everyday. I started uni and can’t study. I used to go the gym but honestly I feel burnt out so I now go occasionally. I have so much uni work but I can’t be bothered. The high school to uni transition has made it super hard for me. I started a business but my social media manager scammed me. I’m afraid to be alone, and when I am alone I distract myself on my phone. Social media drains me. When I’m alone without distractions I think too much. My heart feels like it’s sinking. I don’t want to go to therapy because it’s expensive and I can’t drive myself there. If I tell my parents they’ll make me go on walks and stuff and I don’t want to do that. I want to be left alone when I’m home, but can’t be alone when I’m not. Someone give me tips to manage everything. How do I focus and do assignments. How do I let my brain rest. I’ve tried meditating but I get distracted. I know I need help but I just don’t want to get help, if that makes sense. I also feel sad a lot lately',
      'timestamp': '20 March, 2021',
      'profilePic':
          'https://styles.redditmedia.com/t5_2rpbb/styles/communityIcon_52c202jckjd21.png?width=256&s=84e504e6bcdf3dafbb9fc8f59e38e7820ee2b629',
      'likes': 144,
      'comments': 24,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        leading: Container(),
        title: Text(
          'Healery',
          style: TextStyle(color: Theme.of(context).accentColor),
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
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data[index]['postText'],
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
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
        onTap: (index) => setState(() => _selectedItemPosition = index),
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
