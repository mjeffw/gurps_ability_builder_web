import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';

class TraitNameField extends StatelessWidget {
  const TraitNameField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return TextField(
      // value: value,
      decoration: const InputDecoration(
        labelText: 'Trait name',
        filled: true,
      ),
      onChanged: (name) {
        TraitModel.update(context, TraitModel.copyOf(model, name: name));
      },
      controller: TextEditingController(text: model.name),
    );
  }
}
