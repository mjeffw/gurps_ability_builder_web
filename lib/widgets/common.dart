import 'package:flutter_web/material.dart';

TextField getStandardTextField(String text) {
  return TextField(decoration: InputDecoration(labelText: text, filled: true));
}
