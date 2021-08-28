import 'package:flutter/material.dart';

class MyFlexiAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
        // collapseMode: CollapseMode.pin,

        Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 50.0, 0.0, 0.0),
          child: CircleAvatar(
            radius: 50.0,
          ),
        )
      ],
    );
  }
}
