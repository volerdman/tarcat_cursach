import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarcat_kursach/screens/product_page.dart';
import 'package:tarcat_kursach/services/firebase_services.dart';
import 'package:tarcat_kursach/widgets/custom_action_bar.dart';

class SavedTab extends StatelessWidget {
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future:
                _firebaseServices.getUserId().then((value) => value.toString()),
            builder: (context, userID) {
              return new FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.usersRef
                    .document(userID.data)
                    .collection('Saved')
                    .getDocuments(),
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
                      children: snapshot.data.documents.map((document) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    productId: document.documentID,
                                  ),
                                ));
                          },
                          child: FutureBuilder(
                            future: _firebaseServices.productsRef
                                .document(document.documentID)
                                .get(),
                            builder: (context, productSnap) {
                              if (productSnap.hasError) {
                                return Container(
                                  child: Center(
                                    child: Text("${productSnap.error}"),
                                  ),
                                );
                              }

                              if (productSnap.connectionState ==
                                  ConnectionState.done) {
                                Map _productMap = productSnap.data.data;

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16.0,
                                    horizontal: 24.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            "${_productMap['images'][0]}",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                          left: 16.0,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${_productMap['name']}",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 4.0,
                                              ),
                                              child: Text(
                                                "${_productMap['price']} руб/чел",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Text(
                                              "Количество человек: ${document.data['size']}",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            },
                          ),
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
              );
            },
          ),
          CustomActionBar(
            hasBackArrrow: false,
            title: "Избранное",
          ),
        ],
      ),
    );
  }
}
