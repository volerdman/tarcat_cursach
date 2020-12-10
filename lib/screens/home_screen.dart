import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tarcat_kursach/bottom_tabs/home_tab.dart';
import 'package:tarcat_kursach/bottom_tabs/saved_tabs.dart';
import 'package:tarcat_kursach/bottom_tabs/search_tabs.dart';
import 'package:tarcat_kursach/widgets/bottom_tabs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
    addUser();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              _tabsPageController.animateToPage(num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic);
            },
          ),
        ],
      ),
    );
  }

  Future<void> addUser() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    DocumentReference _firebaseRef =
        Firestore.instance.collection('Users').document(_user.uid);
    return _firebaseRef
        .setData({
          'email': _user.email, // John Doe
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
