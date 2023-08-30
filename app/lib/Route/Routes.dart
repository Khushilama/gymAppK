import 'package:flutter/material.dart';

class Routes {
  static Routes instance = Routes();
  Future<void> push(Widget widget, BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }

  Future<void> pushUtilRemove(Widget widget, BuildContext context) async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget), (route) => false);
  }
}
