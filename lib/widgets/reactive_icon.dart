import 'package:flutter/material.dart';

class ReactiveIcon extends StatelessWidget {
  const ReactiveIcon({this.indicator, this.icon, this.reactiveIconFunction});

  final bool indicator;
  final Function reactiveIconFunction;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Stack(children: [
        icon,
        indicator == true
            ? Positioned(
                // draw a red marble
                top: 0.0,
                right: 0.0,
                child: new Icon(Icons.brightness_1,
                    size: 8.0, color: Color(0xffda0037)),
              )
            : Container(
                width: 0.0,
                height: 0.0,
              )
      ]),
      onPressed: reactiveIconFunction,
    );
  }
}
