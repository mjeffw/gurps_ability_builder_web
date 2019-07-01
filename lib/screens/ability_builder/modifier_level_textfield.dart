import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';

class ModifierLevelTextField extends StatefulWidget {
  const ModifierLevelTextField({
    Key key,
    @required this.model,
    @required this.trait,
    @required this.index,
  }) : super(key: key);

  final Modifier model;
  final TraitModel trait;
  final int index;

  @override
  _ModifierLevelTextFieldState createState() =>
      _ModifierLevelTextFieldState(trait, model, index);
}

class _ModifierLevelTextFieldState extends State<ModifierLevelTextField> {
  final TextEditingController controller;

  TraitModel trait;
  LeveledModifier modifier;
  int index;

  _ModifierLevelTextFieldState(this.trait, this.modifier, this.index)
      : controller = TextEditingController(text: modifier.level.toString());

  @override
  initState() {
    controller.addListener(_signedIntegerListener);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _signedIntegerListener() {
    var digits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String text = '';
    for (var i = 0; i < controller.text.length; i++) {
      var ch = controller.text[i];
      if (i == 0 && (ch == '+' || ch == '-')) {
        text += ch;
      }

      if (digits.contains(ch)) {
        text += ch;
      }
    }

    controller.value = controller.value.copyWith(text: text);
  }

  @override
  void didUpdateWidget(ModifierLevelTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.text = widget.model.percentage.toString();
    trait = widget.trait;
    modifier = widget.model as LeveledModifier;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        print(text);
        var value = int.tryParse(text) ?? modifier.level;
        Modifier m = cloneLeveledModifier(modifier, level: value);
        TraitModel.update(context,
            TraitModel.replaceModifier(trait, index: index, modifier: m));
      },
      textAlign: TextAlign.right,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'[-+]|\d*|[-+]?\d+'))
      ],
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: const InputDecoration(
        labelText: 'Level',
        filled: true,
      ),
      controller: controller,
    );
  }
}
