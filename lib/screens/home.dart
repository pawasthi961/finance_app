import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_app/screens/authenticate/ContinueWithGoogle.dart';
import 'package:finance_app/screens/chat_screen.dart';
import 'file:///C:/Users/Prakhar/AndroidStudioProjects/finance_app/lib/screens/connections/connection_requests.dart';
import 'package:finance_app/screens/home_screen.dart';
import 'package:finance_app/screens/loading.dart';
import 'package:finance_app/screens/notification_screen.dart';
import 'package:finance_app/screens/profile_screen.dart';
import 'package:finance_app/screens/approval_screen.dart';
import 'package:finance_app/screens/connections/connect.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:finance_app/widgets/reactive_icon.dart';

class Home extends StatefulWidget {
  final String userTheme;
  final int pageIndex;
  final bool connectionIndicator;
  final bool notificationIndicator;
  Home(
      {this.userTheme,
      this.pageIndex,
      this.notificationIndicator,
      this.connectionIndicator});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.pageIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    _pageController.jumpToPage(pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    // var signedInUser = Provider.of<DocumentSnapshot>(context);
    // String userTheme = signedInUser.data()["theme"].toString();
    // bool notificationIndicator = signedInUser.data()["notificationIndicator"];
    // Color(0xFF111328);
    // const kActiveCardColour = Color(0xFF1D1E33);
    // 0xFFEB1555
    return SafeArea(
      child: Theme(
        data: widget.userTheme == "dark"
            ? ThemeData.dark().copyWith(
                // scaffoldBackgroundColor: Color(0xFF171717),
                scaffoldBackgroundColor: Colors.black,
                primaryColor: Colors.black,
                // accentColor: Color(0xffda0037),
                // primaryColor: Color(0xFF171717),
                cupertinoOverrideTheme: CupertinoThemeData(
                  barBackgroundColor: Colors.black,
                  // primaryColor: Colors.black
                  // barBackgroundColor: Color(0xff171717),
                  primaryColor: Color(0xFFDA0037),
                  // primaryContrastingColor: Colors.blueGrey
                ),
                tabBarTheme: TabBarTheme(
                  labelColor: Color(0xFFDA0037),
                  unselectedLabelColor: Colors.grey,
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Color(0xFFDA0037),
                  foregroundColor: Colors.white,
                ),
              )
            : ThemeData.light(),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            floatingActionButton: pageIndex == 0
                ? FloatingActionButton(
                    child: Icon(Icons.receipt),
                    onPressed: (() {}),
                  )
                : null,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    leading: IconButton(
                      icon: Icon(
                        Icons.track_changes_rounded,
                        color: Colors.white,
                        size: 26.0,
                      ),
                      onPressed: (() {}),
                    ),
                    actions: <Widget>[
                      ReactiveIcon(
                        indicator: widget.connectionIndicator,
                        icon: Icon(
                          Icons.person_add_outlined,
                          color: Colors.white,
                          size: 26.0,
                        ),
                        reactiveIconFunction: (() async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => ConnectScreen(
                                pageIndex: widget.connectionIndicator ? 0 : 1,
                              ),
                            ),
                          );
                          await DatabaseService()
                              .toggleToFalseConnectionIndicator();
                        }),
                      ),
                      ReactiveIcon(
                        indicator: widget.notificationIndicator,
                        icon: Icon(
                          Icons.notifications_none_outlined,
                          color: Colors.white,
                          size: 26.0,
                        ),
                        reactiveIconFunction: (() async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  NotificationScreen(),
                            ),
                          );
                          await DatabaseService()
                              .toggleToFalseNotificationIndicator();
                        }),
                      ),
                    ],
                    floating: true,
                    pinned: false,
                    snap: true,
                    backgroundColor: Colors.transparent,
                  ),
                ];
              },
              body: PageView(
                children: <Widget>[
                  HomeScreen(),
                  ApprovalScreen(),
                  ChatScreen(),
                  ProfileScreen(),
                ],
                controller: _pageController,
                onPageChanged: onPageChanged,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.white, width: 0.3),
                ),
              ),
              child: CupertinoTabBar(
                currentIndex: pageIndex ?? widget.pageIndex,
                onTap: onTap,
                iconSize: 26.0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      pageIndex == 0 ? Icons.home : Icons.home_outlined,
                      size: 30.0,
                    ),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(
                    pageIndex == 1
                        ? CupertinoIcons.square_stack_3d_up_fill
                        : CupertinoIcons.square_stack_3d_up,
                  )),
                  BottomNavigationBarItem(
                      icon: Icon(
                    pageIndex == 2
                        ? CupertinoIcons.paperplane_fill
                        : CupertinoIcons.paperplane,
                  )),
                  BottomNavigationBarItem(
                    icon: Icon(
                      pageIndex == 3
                          ? CupertinoIcons.person_circle_fill
                          : CupertinoIcons.person_circle,
                    ),
                  ),
                ],
              ),
            ),
            // appBar: AppBar(
            //   elevation: 0.0,
            //   backgroundColor: Colors.transparent,
            //   actions: <Widget>[
            //     IconButton(
            //       icon: Icon(Icons.person_add_rounded),
            //       onPressed: (() {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) =>
            //                 ConnectionRequestScreen(),
            //           ),
            //         );
            //       }),
            //     ),
            //     IconButton(
            //       icon: Stack(children: [
            //         Icon(
            //           Icons.notifications_rounded,
            //         ),
            //         notificationIndicator == true
            //             ? Positioned(
            //                 // draw a red marble
            //                 top: 0.0,
            //                 right: 0.0,
            //                 child: new Icon(Icons.brightness_1,
            //                     size: 8.0, color: Colors.redAccent),
            //               )
            //             : Container(
            //                 width: 0.0,
            //                 height: 0.0,
            //               )
            //       ]),
            //       onPressed: (() async {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (BuildContext context) => ProfileScreen(),
            //           ),
            //         );
            //         await DatabaseService()
            //             .toggleToFalseNotificationIndicator();
            //       }),
            //     ),
            //   ],
            //   leading: IconButton(
            //     icon: Icon(
            //       Icons.track_changes_rounded,
            //     ),
            //     onPressed: (() {}),
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
