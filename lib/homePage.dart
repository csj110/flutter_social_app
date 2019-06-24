import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.4;
  double expandedHeightFactor = 0.85;
  bool isAnimationCompleted = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _heightFactorAnimation =
        Tween(begin: expandedHeightFactor, end: collapsedHeightFactor)
            .animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  onBottomTap() {
    setState(() {
      if (isAnimationCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Scaffold(
            body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: _heightFactorAnimation.value,
              child: Image.asset(
                'images/profile2.jpeg',
                fit: BoxFit.cover,
                height: 400,
                colorBlendMode: BlendMode.hue,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                onBottomTap();
              },
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 1.06 - _heightFactorAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
