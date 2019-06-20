import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';

class TraitNameField extends StatelessWidget {
  final OnChanged onChanged;

  const TraitNameField({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Trait name',
        filled: true,
      ),
      onChanged: onChanged,
    );
  }
}