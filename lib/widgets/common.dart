import 'package:flutter_web/material.dart';

Container buildContainer(Widget widget) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    alignment: Alignment.bottomLeft,
    child: widget,
  );
}
