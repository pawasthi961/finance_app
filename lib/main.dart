import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/models/user.dart';
import 'package:finance_app/screens/wrapper.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              width: 0.0,
              height: 0.0,
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MultiProvider(
              providers: [
                StreamProvider<SignedInUser>.value(
                    value: AuthService().signedInUser),
                StreamProvider<DocumentSnapshot>.value(
                    value: DatabaseService().signedInUserData)
              ],
              child: MaterialApp(
                home: Wrapper(),
              ),
            );
          }
          return Container(
            width: 0.0,
            height: 0.0,
          );
        });
  }
}
