import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContinueWithGoogleButton extends StatelessWidget {
  final Function function;
  ContinueWithGoogleButton({this.function});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          // border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: MaterialButton(
          onPressed: (() {
            function();
          }),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CircleAvatar(
                  radius: 16.0,
                  backgroundColor: Colors.transparent,
                  child:
                      Image.asset("images/google_logo_transparent_colored.png"),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 5.0),
                  child: Text(
                    "Continue with Google",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
