import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;

  clearText() {
    searchTextEditingController.clear();
  }

  searchControl(String str) {
    // Future<QuerySnapshot> allUsers = usersReference.where("profileName", isGreaterThanOrEquaTo: str).getDocuments();
    setState(() {
      // futureSearchResults = allUsers;
    });
  }

  AppBar searchScreenHeader() {
    return AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      title: TextFormField(
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade700),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade700),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          filled: true,
          prefixIcon: Icon(Icons.person, color: Colors.grey, size: 30.0),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              color: Colors.grey,
              onPressed: clearText),
        ),
        onFieldSubmitted: searchControl,
      ),
    );
  }

  Container noResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Icon(Icons.group, color: Colors.grey.shade700, size: 200),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }

  usersFoundScreen() {
    return FutureBuilder(
      future: futureSearchResults,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchScreenHeader(),
      // body: futureSearchResults == null ? noResultScreen : usersFoundScreen,
    );
  }
}
