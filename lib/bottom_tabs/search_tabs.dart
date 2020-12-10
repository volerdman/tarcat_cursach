import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarcat_kursach/services/firebase_services.dart';
import 'package:tarcat_kursach/widgets/custom_input.dart';
import 'package:tarcat_kursach/widgets/product_card.dart';

import '../constant.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Поиск нужной услуги",
                  style: Constants.regularDarkText,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef
                  .orderBy('search_string')
                  .startAt([_searchString]).endAt(
                      ['$_searchString\uf8ff']).getDocuments(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 128.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.documents.map((document) {
                      return ProductCard(
                        title: document.data['name'],
                        imageUrl: document.data['images'][0],
                        price: "${document.data['price']}",
                        productId: document.documentID,
                      );
                    }).toList(),
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: CustomInput(
              hintText: "Поиск...",
              onSubmitted: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
