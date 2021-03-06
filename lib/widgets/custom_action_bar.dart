import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarcat_kursach/screens/cart_page.dart';
import 'package:tarcat_kursach/services/firebase_services.dart';

import '../constant.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasBackArrrow;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar(
      {this.title, this.hasBackArrrow, this.hasTitle, this.hasBackground});

  final FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef = Firestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow = hasBackArrrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                )
              : null),
      padding: EdgeInsets.only(
        top: 56.0,
        left: 24.0,
        right: 24.0,
        bottom: 42.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasBackArrow)
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/back_arrow.png"),
                  color: Colors.white,
                  width: 20.0,
                  height: 16.0,
                ),
              ),
            ),
          if (_hasTitle)
            Text(
              title ?? "Action Bar",
              style: Constants.boldHeading,
            ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
            },
            child: FutureBuilder(
              future: _firebaseServices
                  .getUserId()
                  .then((value) => value.toString()),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return Container(
                    width: 42.0,
                    height: 42.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    alignment: Alignment.center,
                    child: StreamBuilder(
                      stream: _usersRef
                          .document(snapshots.data.toString())
                          .collection('Cart')
                          .snapshots(),
                      builder: (context, snapshot) {
                        int _totalItems = 0;

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          List<DocumentSnapshot> _documents =
                              snapshot.data.documents;
                          _totalItems = _documents.length;
                        }

                        return Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white70,
                            ),
                            Text(
                              "$_totalItems" ?? "0",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
          )
        ],
      ),
    );
  }

  customMethod() async {
    final val = await FirebaseServices().getUserId();
    return val;
  }
}
