// import 'package:finance_app/widgets/my_flexi_app_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:finance_app/widgets/reactive_icon.dart';
// import 'package:finance_app/screens/connections/connect.dart';
// import 'package:finance_app/services/database_service.dart';
// import 'package:finance_app/screens/notification_screen.dart';
//
// class UserEntryParticular extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: CustomScrollView(slivers: <Widget>[
//           SliverAppBar(
//             backgroundColor: Colors.grey,
//             pinned: true,
//             expandedHeight: 200,
//             snap: true,
//             floating: true,
//             stretch: true,
//             // title: Text("Prakhar"),
//             flexibleSpace: FlexibleSpaceBar(background: MyFlexiAppBar()),
//           ),
//           SliverList(
//             delegate: SliverChildListDelegate(
//               <Widget>[
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//                 ListTile(
//                   title: Text("a"),
//                 ),
//                 ListTile(
//                   title: Text("b"),
//                 ),
//               ],
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TwitterProfilePage extends StatefulWidget {
  @override
  _TwitterProfilePageState createState() => _TwitterProfilePageState();
}

class _TwitterProfilePageState extends State<TwitterProfilePage> {
  int _pageIndex;
  static double avatarMaximumRadius = 40.0;
  static double avatarMinimumRadius = 15.0;
  double avatarRadius = avatarMaximumRadius;
  double expandedHeader = 130.0;
  double translate = -avatarMaximumRadius;
  bool isExpanded = true;
  double offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffDA0037),
          child: Icon(Icons.receipt),
        ),
        backgroundColor: Colors.black,
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            final pixels = scrollNotification.metrics.pixels;

            // check if scroll is vertical ( left to right OR right to left)
            final scrollTabs = (scrollNotification.metrics.axisDirection ==
                    AxisDirection.right ||
                scrollNotification.metrics.axisDirection == AxisDirection.left);

            if (!scrollTabs) {
              // and here prevents animation of avatar when you scroll tabs
              if (expandedHeader - pixels <= kToolbarHeight) {
                if (isExpanded) {
                  translate = 0.0;
                  setState(() {
                    isExpanded = false;
                  });
                }
              } else {
                translate = -avatarMaximumRadius + pixels;
                if (translate > 0) {
                  translate = 0.0;
                }
                if (!isExpanded) {
                  setState(() {
                    isExpanded = true;
                  });
                }
              }

              offset = pixels * 0.4;

              final newSize = (avatarMaximumRadius - offset);

              setState(() {
                if (newSize < avatarMinimumRadius) {
                  avatarRadius = avatarMinimumRadius;
                } else if (newSize > avatarMaximumRadius) {
                  avatarRadius = avatarMaximumRadius;
                } else {
                  avatarRadius = newSize;
                }
              });
            }
            return false;
          },
          child: DefaultTabController(
            length: 6,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: expandedHeader,
                  backgroundColor: Colors.grey,
                  leading: BackButton(color: Colors.white),
                  pinned: true,
                  elevation: 5.0,
                  forceElevated: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                        color:
                            isExpanded ? Colors.transparent : Color(0xffDA0037),
                        image: isExpanded
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                                image:
                                    AssetImage("images/twitter_flutter_bg.png"),
                              )
                            : null),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: isExpanded
                          ? Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, avatarMaximumRadius),
                              child: MyAvatar(
                                size: avatarRadius,
                              ),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            isExpanded
                                ? SizedBox(
                                    height: avatarMinimumRadius * 2,
                                  )
                                : MyAvatar(
                                    size: avatarMinimumRadius,
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              // child: Container(
                              //   padding: EdgeInsets.symmetric(
                              //       vertical: 5.0, horizontal: 10.0),
                              //   decoration: BoxDecoration(
                              //     color: Color(0xffDA0037),
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              //   child: Text(
                              //     "Settle",
                              //     style: TextStyle(
                              //         fontSize: 17.0, color: Colors.white),
                              //   ),
                              // ),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Color(0xffDA0037),
                                child: Text(
                                  "Settle",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.0),
                                ),
                                onPressed: (() {}),
                              ),
                            )
                          ],
                        ),
                        TwitterHeader(),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: TwitterTabs(50.0),
                ),
                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (context, index) {
                //       return Tweet();
                //     },
                //   ),
                // ),
                SliverFillRemaining(
                  child: PageView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwitterTabs extends SliverPersistentHeaderDelegate {
  final double size;

  TwitterTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      height: size,
      child: TabBar(
        indicatorColor: Color(0xffDa0037),
        isScrollable: true,
        tabs: <Widget>[
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.receipt_long_outlined),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.receipt_outlined),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.payments_outlined),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.request_page_outlined),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.history_outlined),
            ),
          ),
          Tab(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.person_outline_outlined),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(TwitterTabs oldDelegate) {
    return oldDelegate.size != size;
  }
}

class TwitterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Prakhar Awasthi",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "You Borrowed",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "26",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xfff00000),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "You Lend",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "350",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0xff1dd75f),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 18.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "INR",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        "324",
                        style: TextStyle(
                          color: Color(0xff1dd75f),
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )

          // Row(
          //   children: [
          //     Expanded(
          //       child: Text(
          //         "You Borrowed",
          //         style: TextStyle(color: Colors.grey),
          //       ),
          //     ),
          //     Expanded(
          //       child: Text(
          //         "30,000",
          //         style: TextStyle(color: Colors.green),
          //       ),
          //     ),
          //     Expanded(child: SizedBox())
          //   ],
          // ),
          // Text(
          //   "@flutterio",
          //   style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 15.0,
          //       fontWeight: FontWeight.w200),
          // ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // Text(
          //   "Google’s mobile app SDK for building beautiful native apps on iOS and Android in record time // For support visit http://stackoverflow.com/tags/flutter",
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 15.0,
          //   ),
          // )
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(6.0),
      leading: CircleAvatar(
          // backgroundImage: AssetImage("images/twitter_flutter_logo.jpg"),
          ),
      title: RichText(
        text: TextSpan(
            text: "Flutter",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
            children: [
              TextSpan(
                  text: "  @flutterio  04 Dec 18",
                  style: TextStyle(color: Colors.grey, fontSize: 14)),
            ]),
      ),
      subtitle: Text(
        "We just announced the general availability of Flutter 1.0 at #FlutterLive! \n\nThank you to all the amazing engineers who made this possible and to our awesome community for their support.",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MyAvatar extends StatelessWidget {
  final double size;

  const MyAvatar({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[800],
              width: 2.0,
            ),
            shape: BoxShape.circle),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: size,
            // backgroundImage: AssetImage("images/twitter_flutter_logo.jpg"),
          ),
        ),
      ),
    );
  }
}
