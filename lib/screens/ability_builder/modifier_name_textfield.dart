import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/type_ahead_textfield.dart';

class ModifierNameTextField extends StatefulWidget {
  ModifierNameTextField({
    Key key,
    @required this.index,
    @required this.trait,
    @required this.modifier,
  }) : super(key: key);

  final TraitModel trait;
  final Modifier modifier;
  final int index;

  @override
  _ModifierNameTextFieldState createState() =>
      _ModifierNameTextFieldState(trait, modifier, index);
}

class _ModifierNameTextFieldState extends State<ModifierNameTextField> {
  final TextEditingController controller;

  TraitModel trait;
  Modifier modifier;
  int index;

  _ModifierNameTextFieldState(this.trait, this.modifier, this.index)
      : controller = TextEditingController(text: modifier.name);

  @override
  void didUpdateWidget(ModifierNameTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.text = widget.modifier.name;
    trait = widget.trait;
    modifier = widget.modifier;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
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
          _updateModifier(t);
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
        Modifier m = modifiers.fetch(suggestion);
        TraitModel.update(context,
            TraitModel.replaceModifier(trait, index: index, modifier: m));
      },
    );
  }

  void _updateModifier(String text) {
    Modifier m = BlankModifier(
        isAttackModifier: modifier.isAttackModifier,
        name: text,
        percentage: modifier.percentage);
    TraitModel.update(
        context, TraitModel.replaceModifier(trait, index: index, modifier: m));
  }

  List<String> _suggestionsCallback(String pattern) {
    return modifiers.fetchKeys().where((test) {
      return test.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
  }
}
