import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.67,
          child: Image.asset(
            'images/profile2.jpeg',
            fit: BoxFit.cover,
            height: 400,
            colorBlendMode: BlendMode.hue,
            color: Colors.black,
          ),
        ),
        FractionallySizedBox(
          alignment:Alignment.bottomCenter,
          heightFactor: 1 - 0.67,
          child: Container(
            height: 30,
            color: Colors.teal,
          ),
        )
      ],
    ));
  }
}
