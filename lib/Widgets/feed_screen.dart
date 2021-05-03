import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healery/Providers/auth.dart';
import 'package:healery/Widgets/post_item.dart';
import 'package:healery/main.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        title: Text(
          'Healery',
          style: TextStyle(
            fontSize: 35.0,
            fontFamily: 'Dancing',
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: PaginateFirestore(
            query:
                DB.collection('posts').orderBy('timestamp', descending: true),
            itemsPerPage: 10,
            shrinkWrap: true,
            itemBuilderType: PaginateBuilderType.listView,
            itemBuilder:
                (int index, BuildContext context, DocumentSnapshot data) =>
                    PostItem(
                      data: data,
                    )),
      ),
    );
  }
}
