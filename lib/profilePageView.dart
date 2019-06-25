import 'package:flutter/material.dart';
import './model/profile.dart';

class ProfilePageView extends StatefulWidget {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  double opacity = 0.2;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slidAnimation;
  Animation _fadeAnimation;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _slidAnimation = TweenSequence([
      TweenSequenceItem<Offset>(
          weight: 10, tween: Tween(begin: Offset(0, 0), end: Offset(0, 1))),
      TweenSequenceItem<Offset>(
          weight: 90, tween: Tween(begin: Offset(0, 1), end: Offset(0, 0))),
    ]).animate(_controller);
    _fadeAnimation=TweenSequence([
      TweenSequenceItem<double>(weight: 10,tween: Tween(begin: 1,end:0)),
      TweenSequenceItem<double>(weight: 90,tween: Tween(begin: 0,end:1)),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemBuilder: (context, index) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  profiles[index].imagePath,
                  fit: BoxFit.cover,
                  color: Colors.black,
                  colorBlendMode: BlendMode.hue,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        Colors.black.withOpacity(widget.opacity),
                        Colors.white.withOpacity(widget.opacity),
                        Colors.black.withOpacity(widget.opacity),
                      ])),
                ),
              ],
            );
          },
          pageSnapping: true,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
              _controller.reset();
              _controller.forward();
            });
          },
          scrollDirection: Axis.horizontal,
          controller: widget._controller,
          itemCount: profiles.length,
        ),
        Positioned(
          bottom: 40,
          left: 20,
          right: 20,
          child: ProfileDetails(
            index: currentIndex,
            slideAnimation: _slidAnimation,
            fadeAnimation:_fadeAnimation,
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final int index;
  final Animation slideAnimation;
  final Animation fadeAnimation;
  ProfileDetails({this.index, this.slideAnimation,this.fadeAnimation});
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
          child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstItem: profiles[index].followers.toString(),
              secondItem: 'followers',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.center,
              firstItem: profiles[index].posts.toString(),
              secondItem: 'posts',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.end,
              firstItem: profiles[index].following.toString(),
              secondItem: 'following',
            ),
          ],
        ),
      ),
    );
  }
}

class TwoLineItem extends StatelessWidget {
  final String firstItem, secondItem;
  final CrossAxisAlignment crossAxisAlignment;
  TwoLineItem({this.firstItem, this.secondItem, this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: <Widget>[
        Text(
          firstItem,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        Text(
          secondItem,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w200, fontSize: 16),
        ),
      ],
    );
  }
}
