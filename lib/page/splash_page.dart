//Created by 1vPy on 2020/1/16.
import 'dart:async';

import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/home_page.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key key, this.controller}) : super(key: key) {
    //高度动画
    size = Tween<double>(
      begin: 100,
      end: 200.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );

    rotate = Tween<double>(
      begin: 0,
      end: 360,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6, 1.0, //间隔，后40%的动画时间
          curve: Curves.ease,
        ),
      ),
    );
  }

  final Animation<double> controller;
  Animation<double> size;
  Animation<double> rotate;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Container(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: rotate.value,
        child: FlutterLogo(
          size: size.value,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends BaseState<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(Duration(milliseconds: 500), () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: StaggerAnimation(
          controller: _animationController,
        ),
      ),
    );
  }
}
