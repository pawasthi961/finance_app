import 'package:finance_app/screens/loading.dart';
import 'package:finance_app/widgets/connections/connect_tile.dart';
import 'package:finance_app/widgets/connections/connection_request_tile.dart';
import 'package:finance_app/widgets/connections/connection_requested_tile.dart';
import 'package:finance_app/widgets/connections/connection_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchingStream extends StatelessWidget {
  final String searchName;
  SearchingStream({this.searchName});

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _usersCollection
            .where("nameSearchIndex", arrayContains: searchName)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return new Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Expanded(child: Loading());
          } else if (snapshot.requireData.size == 0) {
            return Text("No such user found");
          }
          final results = snapshot.data.docs;
          final List<Widget> listTiles = [];

          for (var doc in results) {
            List connections = doc.data()['connections'];
            List connectionRequests = doc.data()['connectionRequests'];
            List connectionRequestedTo = doc.data()['connectionRequestedTo'];
            String name = doc.data()["name"];
            if (doc.id == _auth.currentUser.uid.toString()) {
            } else if (connections.contains(_auth.currentUser.uid.toString())) {
              final connectionTile = ConnectionTile(
                name: name,
              );
              listTiles.add(connectionTile);
            } else if (connectionRequests
                .contains(_auth.currentUser.uid.toString())) {
              final connectionRequestedTile = ConnectionRequestedTile(
                name: name,
              );
              listTiles.add(connectionRequestedTile);
            } else if (connectionRequestedTo
                .contains(_auth.currentUser.uid.toString())) {
              final connectionRequestTile = ConnectionRequestTile(
                name: name,
              );
              listTiles.add(connectionRequestTile);
            } else {
              final connectTile = ConnectTile(
                name: name,
              );
              listTiles.add(connectTile);
            }
          }

          return Expanded(
            child: ListView(
              shrinkWrap: true,
              children: listTiles,
            ),
          );
          // return Container(
          //   width: 0.0,
          //   height: 0.0,
          // );
        });
  }
}
