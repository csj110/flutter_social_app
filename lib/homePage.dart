import 'package:flutter/material.dart';
import 'package:social_app/profilePageView.dart';

import 'appbottomBar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _heightFactorAnimation;
  double collapsedHeightFactor = 0.5;
  double expandedHeightFactor = 0.85;
  bool isAnimationCompleted = false;
  double screenHeight = 0;
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

  _handleVerticalUpdate(DragUpdateDetails updateDetails) {
    double fractionDrageed = updateDetails.primaryDelta / screenHeight;
    _controller.value = _controller.value - 2 * fractionDrageed;
  }

  _handleVerticalEnd(DragEndDetails endDetails) {
    if (isAnimationCompleted) {
      if (_controller.value < 0.9) {
        _controller.fling(velocity: -2);
        isAnimationCompleted = !isAnimationCompleted;
      } else {
        _controller.fling(velocity: 1);
      }
    } else {
      if (_controller.value > 0.1) {
        _controller.fling(velocity: 2);
        isAnimationCompleted = !isAnimationCompleted;
      } else {
        _controller.fling(velocity: -1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Scaffold(
            backgroundColor: Color(0xffeeeeee),
            bottomNavigationBar: AppBottomBar(),
            body: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: _heightFactorAnimation.value,
                  child: ProfilePageView(),
                ),
                GestureDetector(
                  // onTap: onBottomTap,
                  onVerticalDragUpdate: _handleVerticalUpdate,
                  onVerticalDragEnd: _handleVerticalEnd,
                  child: FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1.06 - _heightFactorAnimation.value,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xffeeeeee),
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
