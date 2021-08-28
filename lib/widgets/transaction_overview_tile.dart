// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TransactionOverviewTile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Color(0xFF1D1E33),
//       // elevation: 10.0,
//
//       shape: RoundedRectangleBorder(
//           // side: BorderSide(color: Color(0xFF111328)),
//           borderRadius: BorderRadius.circular(20.0)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CircleAvatar(
//                     child: ClipRRect(
//                       child: Image(
//                         image: NetworkImage(
//                             "https://lh3.googleusercontent.com/a-/AOh14GjhRWAvV-OJU_Xa6UdlyM6p48h2y6VvdfKCMZn6HA=s96-c"),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 5,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Prakhar Awasthi",
//                     style:
//                         TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Icon(
//                         Icons.receipt,
//                         size: 18.0,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Icon(
//                         Icons.payments,
//                         size: 18.0,
//                         color: Colors.greenAccent,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(4.0),
//                       child: Icon(
//                         Icons.request_page,
//                         size: 18.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(8.0, 4.0, 0.0, 0.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "You Borrowed :",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       SizedBox(
//                         height: 4.0,
//                       ),
//                       Text("You lent :", style: TextStyle(color: Colors.grey)),
//                       SizedBox(
//                         height: 4.0,
//                       ),
//                       Text("Prakhar requested:",
//                           style: TextStyle(color: Colors.grey)),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 2,
//                 // child: Column(
//                 //   children: [],
//                 // ),
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             "3420",
//                             style: TextStyle(
//                                 fontSize: 45.0,
//                                 // color: Color(0xff00b13f)
//                                 color: Color(0xfff60000),
//                                 // color: Color(0xff1dd75f),
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 8.0,
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:finance_app/screens/user_entry_particular.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TransactionOverviewTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.0),
        child: Image(
          image: NetworkImage(
              "https://lh3.googleusercontent.com/a-/AOh14GjhRWAvV-OJU_Xa6UdlyM6p48h2y6VvdfKCMZn6HA=s96-c"),
          height: 80.0,
          width: 80.0,
        ),
      ),
    );

    final planetCard = Container(
      child: Container(
        child: Row(
          children: [
            SizedBox(
              width: 50,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.receipt,
                            size: 15.0,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.payment,
                            size: 15.0,
                            color: Colors.greenAccent,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.request_page,
                            size: 15.0,
                            color: Colors.yellowAccent,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
                      child: Text(
                        "Prakhar Awasthi",
                        style: TextStyle(
                          fontSize: 20.0,
                          // fontFamily: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("You Borrowed ",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey)),
                                    Text("You Lend ",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey)),
                                    // Text("Prakhar : ",
                                    //     style: TextStyle(
                                    //         fontSize: 13.0, color: Colors.grey))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "26",
                                      style: TextStyle(
                                          fontSize: 13.0, color: Colors.grey),
                                    ),
                                    Text("350",
                                        style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey)),
                                    // Text("80,0800",
                                    //     style: TextStyle(
                                    //         fontSize: 13.0, color: Colors.grey)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "INR",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "324",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Color(0xfff60000),
                                    // color: Color(0xff1dd75f)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // height: 124.0,
      margin: EdgeInsets.only(left: 40.0),
      decoration: BoxDecoration(
        color: Color(0xFF171717),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => TwitterProfilePage(),
          ),
        );
      }),
      child: Container(
        height: 116.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      ),
    );
  }
}
