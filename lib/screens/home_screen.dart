import 'package:flutter/material.dart';
import 'package:tarcat_kursach/widgets/bottom_tabs.dart';

import '../constant.dart';

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
                Container(
                  child: Center(
                    child: Text(
                      "HomePage",
                      style: Constants.regularHeading,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "SearchPage",
                      style: Constants.regularHeading,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                    child: Text(
                      "SavedPage",
                      style: Constants.regularHeading,
                    ),
                  ),
                ),
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
}
