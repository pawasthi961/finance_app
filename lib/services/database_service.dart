import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  Stream<DocumentSnapshot> get signedInUserData {
    return _auth.currentUser != null
        ? FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser.uid)
            .snapshots()
        : null;
  }

  Stream<QuerySnapshot> get currentUser {
    return _users.snapshots();
  }

  Future<void> addUser({
    String name,
    String email,
    String photoUrl,
    String uid,
    String phoneNumber,
    String theme,
  }) async {
    // Call the user's CollectionReference to add a new user
    DocumentReference ref = await _users.doc(uid).set({
      'name': name ?? "",
      'email': email ?? "",
      'photoUrl': photoUrl ?? "",
      'uid': uid ?? "",
      'phoneNumber': phoneNumber ?? "",
      'theme': theme ?? "",
    }).then((value) {
      print("user added");
    }).catchError((error) => print("Failed to add user: $error"));
    print(ref);
  }

  Future<void> toggleToFalseNotificationIndicator() async {
    await _users
        .doc(_auth.currentUser.uid)
        .update({"notificationIndicator": false}).then((value) {
      print("Notification indicator successfully set to false");
    }).catchError((error) => print("error $error"));
  }

  Future<void> toggleToTrueNotificationIndicator() async {
    await _users
        .doc(_auth.currentUser.uid)
        .update({"notificationIndicator": true}).then((value) {
      print("Notification indicator successfully set to false");
    }).catchError((error) => print("error $error"));
  }

  Future<void> toggleToFalseConnectionIndicator() async {
    await _users
        .doc(_auth.currentUser.uid)
        .update({"connectionIndicator": false}).then((value) {
      print("connection indicator successfully set to false");
    }).catchError((error) => print("error $error"));
  }

  Future<void> toggleToTrueConnectionIndicator() async {
    await _users
        .doc(_auth.currentUser.uid)
        .update({"connectionIndicator": true}).then((value) {
      print("connection indicator successfully set to false");
    }).catchError((error) => print("error $error"));
  }

  List creatingNameSearchIndex(String name) {
    List<String> splitList = name.split(" ");
    List<String> indexList = [];
    for (int i = 1; i < name.length + 1; i++) {
      indexList.add(name.substring(0, i).toLowerCase());
    }
    for (int i = 0; i < splitList.length; i++) {
      for (int y = 1; y < splitList[i].length + 1; y++) {
        indexList.add(splitList[i].substring(0, y).toLowerCase());
      }
    }
    return indexList;
  }

  Future<void> addingNameSearchIndex() async {
    List nameSearchIndex = creatingNameSearchIndex("ayush kumar");
    await _users
        .doc("Fo3Fpqg8xdEco6v9UNMZ")
        .update({'nameSearchIndex': nameSearchIndex})
        .then((value) => print("added"))
        .catchError((e) {
          print(e);
        });
  }

  Future<QuerySnapshot> getAllUsers() async {
    return await _users.get();
  }
}
