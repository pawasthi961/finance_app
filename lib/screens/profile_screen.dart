import 'package:finance_app/screens/authenticate/ContinueWithGoogle.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Profile Screen"),
      RaisedButton(
        onPressed: (() async {
          await AuthService().signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ContinueWithGoogle()),
              (Route<dynamic> route) => false);
        }),
        child: Text("Logout"),
      )
    ]);
  }
}
