import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okacard/screens/homescreen.dart';

class Router {
  static const String HOME = 'HOME';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME:
        // CONNECT hasn't been implemented yet
        return CupertinoPageRoute(builder: (_) => HomeScreen());
      default:
        return CupertinoPageRoute(builder: (_) => HomeScreen());
    }
  }
}
