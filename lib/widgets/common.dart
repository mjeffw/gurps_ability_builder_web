import 'package:flutter_web/material.dart';

typedef void OnChanged<T>(T value);

TextField getStandardTextField(String text) {
  return TextField(decoration: InputDecoration(labelText: text, filled: true));
}
