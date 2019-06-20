import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';

class TraitNameField extends StatelessWidget {
  final OnChanged<String> onChanged;
  final String value;

  const TraitNameField({Key key, this.onChanged, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      // value: value,
      decoration: const InputDecoration(
        labelText: 'Trait name',
        filled: true,
      ),
      onChanged: onChanged,
      controller: TextEditingController(text: value),
    );
  }
}
