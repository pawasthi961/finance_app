import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConnectionRequestTile extends StatelessWidget {
  final String name;
  ConnectionRequestTile({this.name});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      color: Color(0xff171717),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 30.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Image.network(
                      "https://lh3.googleusercontent.com/a-/AOh14GjhRWAvV-OJU_Xa6UdlyM6p48h2y6VvdfKCMZn6HA=s96-c"),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: RaisedButton(
                          color: Colors.lightBlueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            "Confirm",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (() {}),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: RaisedButton(
                          color: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Text(
                            "Decline",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (() {}),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
