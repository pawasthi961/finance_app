import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntryRequestTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      color: Color(0xff171717),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Prakhar Awasthi",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        Icons.receipt,
                        size: 22.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Borrowed",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "INR",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white38,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "On",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "12 Sept 2021",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white70),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "For",
                              style: TextStyle(
                                color: Colors.white38,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Chips",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        "34",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Color(0xfff60000),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: (() {}),
                        color: Colors.pinkAccent,
                        child: Row(
                          children: [
                            Icon(Icons.remove_circle_rounded),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text("Discard"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: (() {}),
                        color: Colors.lightBlueAccent,
                        child: Row(
                          children: [
                            Icon(Icons.add_circle_rounded),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                              "Add",
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    )
                  ],
                ),
                SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
