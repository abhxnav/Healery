import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healery/main.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = TextEditingController();
  List<QueryDocumentSnapshot> result = [];
  bool isLoading = false;
  bool noResult = true;

  clearText() {
    searchTextEditingController.clear();
  }

  searchControl(String value) async {
    setState(() {
      isLoading = true;
    });

    if (value.trim().toLowerCase().length > 2) {
      try {
        setState(() {
          result = [];
        });

        List<QueryDocumentSnapshot> firstResult = await DB
            .collection('users')
            .orderBy('caseInsensitiveFullName')
            .startAt([value.trim().toLowerCase()])
            .endAt(["${value.trim().toLowerCase()}\uf8ff"])
            .get()
            .then((value) => value.docs);

        bool isDuplicate;

        for (int i = 0; i < firstResult.length - 1; i++) {
          isDuplicate = false;

          for (int j = i + 1; j < firstResult.length; j++) {
            if (firstResult[i].data()['userID'] ==
                firstResult[j].data()['userID']) {
              isDuplicate = true;
              break;
            }
          }
          if (!isDuplicate) {
            result.add(firstResult[i]);
          }
        }

        try {
          result.add(firstResult[firstResult.length - 1]);
        } catch (e) {}

        setState(() {
          result;
          if (result.length < 1) {
            noResult = true;
          } else {
            noResult = false;
          }
        });
      } catch (error) {}
    } else {
      setState(() {
        result = [];
      });
    }

    setState(() {
      isLoading = false;
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

  Container loadingScreen() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 70),
      child: Center(
        child: Transform.scale(scale: 0.6, child: CircularProgressIndicator()),
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
            Icon(Icons.group, color: Colors.grey.shade700, size: 100),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  Container resultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: result.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(result[index].data()['name']),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              image: DecorationImage(
                image: NetworkImage(
                  result[index].data()['profilePic'],
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchScreenHeader(),
      body: isLoading
          ? loadingScreen()
          : result == null || noResult
              ? noResultScreen()
              : resultScreen(),
    );
  }
}
