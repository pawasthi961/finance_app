import 'package:finance_app/screens/connections/connection_requests.dart';
import 'package:finance_app/screens/connections/search.dart';
import 'package:finance_app/screens/loading.dart';
import 'package:finance_app/services/database_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectScreen extends StatefulWidget {
  final int pageIndex;
  ConnectScreen({this.pageIndex});
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  int _pageIndex;
  bool isLoading;
  void toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  PageController _pageController;
  void _toggleScreen() {
    if (_pageIndex == 0) {
      _pageController.jumpToPage(1);
    } else {
      _pageController.jumpToPage(0);
    }
    print(_pageIndex);
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.pageIndex);
    _pageIndex = widget.pageIndex;
    isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          accentColor: Color(0xffda0037),
        ),
        child: Stack(children: [
          Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  CupertinoSliverNavigationBar(
                    trailing: _pageIndex == 0
                        ? IconButton(
                            icon: Icon(Icons.search_rounded),
                            onPressed: (() {
                              _toggleScreen();
                            }))
                        : IconButton(
                            icon: Icon(Icons.group),
                            onPressed: (() {
                              _toggleScreen();
                            }),
                          ),
                    largeTitle: Text(
                      "Connect",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        // fontWeight: FontWeight.w100
                      ),
                    ),
                    actionsForegroundColor: Colors.white,
                    backgroundColor: Colors.black,
                  )
                  // new SliverAppBar(
                  //   floating: true,
                  //   pinned: false,
                  //   snap: true,
                  //   backgroundColor: Colors.transparent,
                  //   actions: [
                  //     _pageIndex == 0
                  //         ? IconButton(
                  //             icon: Icon(Icons.search_rounded),
                  //             onPressed: (() {
                  //               _toggleScreen();
                  //             }))
                  //         : IconButton(
                  //             icon: Icon(Icons.group),
                  //             onPressed: (() {
                  //               _toggleScreen();
                  //             }))
                  //   ],
                  // ),
                ];
              },
              body: PageView(
                controller: _pageController,
                onPageChanged: onPageChanged,
                children: [
                  ConnectionRequestScreen(),
                  SearchScreen(
                    toggleLoading: toggleLoading,
                  ),
                ],
              ),
            ),
          ),
          isLoading ? Loading() : Container(height: 0.0, width: 0.0)
        ]),
      ),
    );
  }
}
