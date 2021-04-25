import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadMore extends StatefulWidget {
  @override
  _LoadMoreState createState() => _LoadMoreState();
}

class _LoadMoreState extends State<LoadMore> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Center(
        child: SpinKitFadingCube(
          color: Theme.of(context).primaryColor,
          size: 30,
          controller: AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1200),
          ),
        ),
      ),
    );
  }
}
