import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarcat_kursach/widgets/custom_action_bar.dart';
import 'package:tarcat_kursach/widgets/product_card.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      Firestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.getDocuments(),
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
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.documents.map((doc) {
                    return ProductCard(
                      title: doc.data['name'],
                      imageUrl: doc.data['images'][0],
                      price: "${doc.data['price']}",
                      productId: doc.documentID,
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
          CustomActionBar(
            title: "Главная",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
