import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';

class ModifierLevelTextField extends StatefulWidget {
  const ModifierLevelTextField({
    Key key,
    @required this.trait,
    @required this.index,
  }) : super(key: key);

  final TraitModel trait;
  final int index;

  @override
  _ModifierLevelTextFieldState createState() =>
      _ModifierLevelTextFieldState(trait, index);
}

class _ModifierLevelTextFieldState extends State<ModifierLevelTextField> {
  final TextEditingController controller;

  TraitModel trait;
  int index;

  _ModifierLevelTextFieldState(this.trait, this.index)
      : controller = TextEditingController(
            text: (trait.modifiers[index] as LeveledModifier).level.toString());

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
    trait = widget.trait;
    index = widget.index;
    controller.text =
        (trait.modifiers[index] as LeveledModifier).level.toString();
  }

  @override
  Widget build(BuildContext context) {
    LeveledModifier modifier = trait.modifiers[index] as LeveledModifier;

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
