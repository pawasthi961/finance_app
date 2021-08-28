import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0XFF171717),
        ),
        child: CupertinoPageScaffold(
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  backgroundColor: Colors.transparent,
                  actionsForegroundColor: Colors.white,
                  largeTitle: Text(
                    "Notifications",
                    style: TextStyle(
                      // fontFamily: "Poppins",
                      color: Color(0xffededed),
                    ),
                  ),
                ),
              ];
            },
            body: Container(),
          ),
        ),
        // child: Scaffold(
        //   body: NestedScrollView(
        //     headerSliverBuilder:
        //         (BuildContext context, bool innerBoxIsScrolled) {
        //       return <Widget>[
        //         new SliverAppBar(
        //           floating: true,
        //           pinned: false,
        //           snap: true,
        //           backgroundColor: Colors.transparent,
        //         ),
        //       ];
        //     },
        //     body: Container(
        //       child: Text("Notifications"),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
