import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/type_ahead_textfield.dart';

class ModifierNameTextField extends StatefulWidget {
  ModifierNameTextField({
    Key key,
    @required this.index,
    @required this.trait,
  }) : super(key: key);

  final TraitModel trait;
  final int index;

  @override
  _ModifierNameTextFieldState createState() =>
      _ModifierNameTextFieldState(trait, index);
}

class _ModifierNameTextFieldState extends State<ModifierNameTextField> {
  final TextEditingController controller;

  TraitModel trait;
  int index;

  _ModifierNameTextFieldState(this.trait, this.index)
      : controller = TextEditingController(text: trait.modifiers[index].name);

  @override
  void didUpdateWidget(ModifierNameTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    trait = widget.trait;
    index = widget.index;
    controller.text = trait.modifiers[index].name;
  }

  @override
  Widget build(BuildContext context) {
    Modifier modifier = trait.modifiers[index];
    bool editable = modifier is BlankModifier;

    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: editable,
        controller: controller,
        enabled: editable,
        decoration: InputDecoration(
          labelText: 'Modifier Name',
          filled: true,
        ),
        onChanged: (t) {
          _updateModifier(modifier, t);
        },
      ),
      hideOnEmpty: true,
      suggestionsCallback: (pattern) async {
        return await _suggestionsCallback(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(title: Text(suggestion), dense: true);
      },
      onSuggestionSelected: (suggestion) {
        Modifier m = Modifiers.instance().fetch(suggestion);
        TraitModel.update(context,
            TraitModel.replaceModifier(trait, index: index, modifier: m));
      },
    );
  }

  void _updateModifier(Modifier modifier, String text) {
    Modifier m = BlankModifier(
        isAttackModifier: modifier.isAttackModifier,
        name: text,
        percentage: modifier.percentage);
    TraitModel.update(
        context, TraitModel.replaceModifier(trait, index: index, modifier: m));
  }

  List<String> _suggestionsCallback(String pattern) {
    return Modifiers.instance().fetchKeys().where((test) {
      return test.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
  }
}
