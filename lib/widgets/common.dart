import 'package:flutter_web/material.dart';

TextField getStandardTextField({String label}) {
  return TextField(decoration: InputDecoration(labelText: label, filled: true));
}
