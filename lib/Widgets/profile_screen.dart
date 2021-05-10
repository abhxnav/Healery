import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/auth_screen.dart';
import 'package:healery/Widgets/post_item.dart';
import 'package:healery/main.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<QueryDocumentSnapshot> posts = [];
  int likes = 0;

  Future load() async {
    posts = await DB
        .collection('posts')
        .where('userID', isEqualTo: auth.user.uid)
        .get()
        .then((value) => value.docs);
    for (var post in posts) {
      likes += post.data()['likes'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "username",
          style: TextStyle(
              fontSize: 20,
              fontFamily: 'Balsamiq',
              letterSpacing: 1.5,
              color: Colors.white),
        ),
      ),
      drawer: MyDrawer(),
      body: FutureBuilder(
        future: load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 60, right: 60, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage(auth.userData['profilePic']),
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (auth.userData["name"]),
                            style: TextStyle(
                              fontFamily: 'Balsamiq',
                              fontSize: 20,
                            ),
                          ),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Icon(Icons.location_on,
                          //         color: Colors.white, size: 12),
                          //     Padding(
                          //       padding: const EdgeInsets.only(left: 6),
                          //       child: Text(
                          //         'location',
                          //         style: TextStyle(
                          //           fontFamily: 'Balsamiq',
                          //           color: Colors.white,
                          //           wordSpacing: 2,
                          //           letterSpacing: 4,
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 1)
                            ),
                            child: Text(
                              'edit profile',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontFamily: 'Balsamiq',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 1, bottom: 10, right: 40, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '2',
                            style: TextStyle(
                              fontFamily: 'Balsamiq',
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            'Posts',
                            style: TextStyle(
                              fontFamily: 'Balsamiq',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        width: 0.2,
                        height: 22,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            likes.toString(),
                            style: TextStyle(
                              fontFamily: 'Balsamiq',
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            "likes",
                            style: TextStyle(
                              fontFamily: 'Balsamiq',
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        width: 0.2,
                        height: 22,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).canvasColor,
                        child: Text(
                          'follow +',
                          style: TextStyle(
                            fontFamily: 'Balsamiq',
                            color: Colors.white,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: PaginateFirestore(
                        query: DB
                            .collection('posts')
                            .where('userID', isEqualTo: auth.user.uid),
                        itemsPerPage: 10,
                        shrinkWrap: true,
                        itemBuilderType: PaginateBuilderType.listView,
                        itemBuilder: (int index, BuildContext context,
                                DocumentSnapshot data) =>
                            PostItem(
                              data: data,
                            )),
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// class Header extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color(0xFF6f5975);
//     Path path = Path()
//       ..relativeLineTo(0, 50)
//       ..quadraticBezierTo(size.width / 2, 150, size.width, 50)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

class MyDrawer extends StatelessWidget {
  final Function onTap;
  MyDrawer({this.onTap});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).accentColor),
              child: Padding(
                padding: EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage(auth.userData['profilePic']),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      (auth.userData["name"]),
                      style: TextStyle(
                        fontFamily: 'Balsamiq',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Username',
                      style: TextStyle(
                        fontFamily: 'Balsamiq',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_searching_outlined),
              title: Text(
                'Location',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.mood_outlined),
              title: Text(
                'Know your Mental Status',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.equalizer_outlined),
              title: Text(
                'Mood History',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.my_library_books_outlined),
              title: Text(
                'Resources',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.lock_open_outlined),
              title: Text(
                'Privacy Policy',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () => onTap(context, 0),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'Balsamiq',
                ),
              ),
              onTap: () async {
                await auth.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AuthScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

// TextButton(),
// TextButton(
//   child: Container(
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             Icons.settings,
//           ),
//         ),
//         Text(
//           'Account Settings',
//           style: TextStyle(
//             letterSpacing: 1.5,
//             fontFamily: 'Balsamiq',
//             fontWeight: FontWeight.bold,
//             fontSize: 15.0,
//           ),
//         ),
//         SizedBox(width: 157),
//         Icon(
//           Icons.arrow_forward_ios_outlined,
//           size: 15,
//         ),
//       ],
//     ),
//     margin: EdgeInsets.all(10.0),
//     height: 40.0,
//     decoration: BoxDecoration(
//       color: Theme.of(context).canvasColor,
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//   ),
// ),
// TextButton(
//   child: Container(
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             Icons.security_outlined,
//           ),
//         ),
//         Text(
//           'Security',
//           style: TextStyle(
//             letterSpacing: 1.5,
//             fontFamily: 'Balsamiq',
//             fontWeight: FontWeight.bold,
//             fontSize: 15.0,
//           ),
//         ),
//         SizedBox(width: 230),
//         Icon(
//           Icons.arrow_forward_ios_outlined,
//           size: 15,
//         ),
//       ],
//     ),
//     margin: EdgeInsets.all(10.0),
//     height: 40.0,
//     decoration: BoxDecoration(
//       color: Theme.of(context).canvasColor,
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//   ),
// ),
// TextButton(
//   onPressed: () async {
//     await auth.signOut();
//     Navigator.pushReplacement(context,
//         MaterialPageRoute(builder: (context) => AuthScreen()));
//   },
//   child: Container(
//     child: Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Icon(
//             Icons.logout,
//           ),
//         ),
//         Text(
//           'Logout',
//           style: TextStyle(
//             letterSpacing: 1.5,
//             fontFamily: 'Balsamiq',
//             fontWeight: FontWeight.bold,
//             fontSize: 15.0,
//           ),
//         ),
//         SizedBox(width: 240),
//         Icon(
//           Icons.arrow_forward_ios_outlined,
//           size: 15,
//         ),
//       ],
//     ),
//     margin: EdgeInsets.all(10.0),
//     height: 40.0,
//     decoration: BoxDecoration(
//       color: Theme.of(context).canvasColor,
//       borderRadius: BorderRadius.circular(10.0),
//     ),
//   ),
// ),

// Column(
//   mainAxisAlignment: MainAxisAlignment.end,
//   children: [
//     Container(
//       height: 450,
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       ),
//     ),
//   ],
// ),
// CustomPaint(
//   child: Container(
//     width: MediaQuery.of(context).size.width,
//     height: MediaQuery.of(context).size.height,
//   ),
//   painter: Header(),
// ),

// SizedBox(height: 20),
// Padding(
//   padding: EdgeInsets.all(20),
//   child: Text(
//     "Profile",
//     style: TextStyle(
//         fontSize: 25,
//         fontFamily: 'Balsamiq',
//         letterSpacing: 1.5,
//         color: Colors.white,
//         fontWeight: FontWeight.w600),
//   ),
// ),

// RaisedButton(
// textColor: Colors.white,
// child: Text(
// 'edit profile',
// style: TextStyle(
// fontFamily: 'Balsamiq',
// color: Colors.white,
// ),
// ),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// onPressed: null,
// ),
