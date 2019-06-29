import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';

class ModifierPercentageTextField extends StatefulWidget {
  const ModifierPercentageTextField({
    Key key,
    @required this.model,
    @required this.trait,
    @required this.index,
  }) : super(key: key);

  final Modifier model;
  final TraitModel trait;
  final int index;

  @override
  _ModifierPercentageTextFieldState createState() =>
      _ModifierPercentageTextFieldState(trait, model, index);
}

class _ModifierPercentageTextFieldState
    extends State<ModifierPercentageTextField> {
  final TextEditingController controller;

  TraitModel trait;
  Modifier modifier;
  int index;

  _ModifierPercentageTextFieldState(this.trait, this.modifier, this.index)
      : controller =
            TextEditingController(text: modifier.percentage.toString());

  @override
  initState() {
    controller.addListener(_signedIntegerListener);
    super.initState();
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
  void didUpdateWidget(ModifierPercentageTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.text = widget.model.percentage.toString();
    trait = widget.trait;
    modifier = widget.model;
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (text) {
        print(text);
        var value = int.tryParse(text) ?? modifier.percentage;
        Modifier m = cloneModel(modifier, percentage: value);
        TraitModel.update(context,
            TraitModel.replaceModifier(trait, index: index, modifier: m));
      },
      textAlign: TextAlign.right,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'[-+]|\d*|[-+]?\d+'))
      ],
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: const InputDecoration(
        labelText: 'Value',
        filled: true,
        suffix: Text('%'),
      ),
      controller: controller,
    );
  }
}
