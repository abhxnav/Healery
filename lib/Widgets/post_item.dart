import 'package:flutter/material.dart';
import 'package:healery/main.dart';

class PostItem extends StatelessWidget {
  final data;

  const PostItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DB.collection('users').doc(data.data()['userID']).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 10),
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(
                        snapshot.data['profilePic'],
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      snapshot.data['name'],
                      style: TextStyle(
                          fontFamily: 'Balsamiq', fontWeight: FontWeight.w500),
                    ),
                    Spacer(),
                    Text(data.data()['timestamp'].toString(),
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data.data()['title'],
                    style: TextStyle(
                        fontFamily: 'Balsamiq',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    data.data()['content'],
                    style: TextStyle(
                        fontFamily: 'Balsamiq',
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    Icon(Icons.favorite_rounded, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      data.data()['likes'].toString(),
                      style: TextStyle(
                          fontFamily: 'Balsamiq', fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 30),
                    Icon(Icons.message_rounded),
                    SizedBox(width: 5),
                    Text(
                      data.data()['comments'].toString(),
                      style: TextStyle(
                          fontFamily: 'Balsamiq', fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Container(
              height: 20,
              color: Theme.of(context).backgroundColor,
            );
          }
        });
  }
}
