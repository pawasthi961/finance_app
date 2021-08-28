import 'package:flutter/material.dart';

class ConnectionTile extends StatelessWidget {
  final String name;
  ConnectionTile({this.name});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      color: Color(0xff171717),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image(
                    image: NetworkImage(
                        "https://lh3.googleusercontent.com/a-/AOh14GjhRWAvV-OJU_Xa6UdlyM6p48h2y6VvdfKCMZn6HA=s96-c" ??
                            null),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Text(
                      "Already your connection",
                      style: TextStyle(fontSize: 11.0, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
