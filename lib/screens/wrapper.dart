import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/screens/authenticate/newUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/screens/authenticate/ContinueWithGoogle.dart';
import 'package:finance_app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/screens/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUserData = Provider.of<DocumentSnapshot>(context);
    if (FirebaseAuth.instance.currentUser == null) {
      return ContinueWithGoogle();
    } else {
      print(FirebaseAuth.instance.currentUser);
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CupertinoActivityIndicator(
                radius: 20.0,
              );
            } else {
              final userTheme = snapshot.data["theme"].toString();
              final notificationIndicator =
                  snapshot.data["notificationIndicator"];
              final connectionIndicator = snapshot.data["connectionIndicator"];
              print(userTheme);
              return Home(
                userTheme: userTheme,
                notificationIndicator: notificationIndicator,
                connectionIndicator: connectionIndicator,
                pageIndex: 0,
              );
              // return NewUser();
            }
          });
    }
  }
}
