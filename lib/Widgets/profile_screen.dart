import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Screens/auth_screen.dart';

class ProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO design profile screen

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).accentColor),
          onPressed: () {},
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
              ),
            ],
          ),
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            painter: Header(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 35,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/Images/avatar.png'),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                              Text(
                                'POSTS',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                  ),
                  Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                              Text(
                                'FOLLOWERS',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                  ),
                  Expanded(
                      child:Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '000',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              ),
                              Text(
                                'LIKES',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.white60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        margin: EdgeInsets.all(10.0),
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.lock,
                      ),
                    ),
                    Text(
                      'Privacy',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 217),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
                height: 70.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.security_outlined,
                      ),
                    ),
                    Text(
                      'Security',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 209),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
                height: 70.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.info,
                      ),
                    ),
                    Text(
                      'About',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(width: 230),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.all(10.0),
                height: 70.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class Header extends CustomPainter {
  @override

  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xFF6f5975);
    Path path = Path()..relativeLineTo(0, 150)..quadraticBezierTo(size.width/2, 225, size.width, 150)..relativeLineTo(0, -150)..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// Image.network(auth.userData['profilePic']),
// Text(auth.userData["name"]),
// TextButton(
// onPressed: () async {
// await auth.signOut();
// Navigator.pushReplacement(context,
// MaterialPageRoute(builder: (context) => AuthScreen()));
// },
// child: Text('Log out')),
// ],


// Column(
// children: [
// Expanded(child: Card()),
// Expanded(child: Card()),
// Expanded(child: Card()),
// Expanded(child: Card()),
// Expanded(child: Card()),
// ],
// ),


// Padding(
// padding: EdgeInsets.only(bottom: 270, left: 184),
// child: CircleAvatar(
// backgroundColor: Colors.black,
// child: IconButton(
// icon: Icon(
// Icons.edit,
// color: Colors.white,
// ),
// onPressed: () {},
// ),
// ),
// ),