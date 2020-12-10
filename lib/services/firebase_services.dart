import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  Future<String> getUserId() async {
    FirebaseUser _firebaseAuth = await FirebaseAuth.instance.currentUser();
    final String userId = _firebaseAuth.uid.toString();
    return userId;
  }

  final CollectionReference productsRef =
      Firestore.instance.collection('Products');

  final CollectionReference usersRef = Firestore.instance.collection('Users');
}
