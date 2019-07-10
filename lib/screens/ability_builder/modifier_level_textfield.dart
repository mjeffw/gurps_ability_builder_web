import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';

typedef int ModifyLevel(int level);
typedef bool Predicate();

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
        int value = int.tryParse(text) ?? modifier.level;
        _updateLevel(modifier, (x) => value, context);
      },
      textAlign: TextAlign.right,
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'[-+]|\d*|[-+]?\d+'))
      ],
      keyboardType: TextInputType.numberWithOptions(signed: true),
      decoration: InputDecoration(
        labelText: 'Level',
        filled: true,
        prefixIcon: InkWell(
          child: Icon(Icons.skip_previous,
              color: _iconColor(() => modifier.level > 1)),
          onTap:
              _tapCallback(() => modifier.level > 1, _decrementLevel, modifier),
        ),
        suffixIcon: InkWell(
            child: Icon(
              Icons.skip_next,
              color: _iconColor(() => modifier.level != modifier.maxLevel),
            ),
            onTap: _tapCallback(() => modifier.level != modifier.maxLevel,
                _incrementLevel, modifier)),
      ),
      controller: controller,
    );
  }

  GestureTapCallback _tapCallback(
      Predicate shouldEnable, ModifyLevel modifyLevel, Modifier modifier) {
    return (shouldEnable.call())
        ? () => _updateLevel(modifier, modifyLevel, context)
        : null;
  }

  int _decrementLevel(int level) => level - 1;
  int _incrementLevel(int level) => level + 1;

  Color _iconColor(Predicate predicate) {
    if (predicate.call()) {
      return null;
    }
    return Colors.grey.shade200;
  }

  void _updateLevel(LeveledModifier modifier, ModifyLevel _modifyLevel,
      BuildContext context) {
    Modifier m = cloneLeveledModifier(modifier,
        level: _modifyLevel.call(modifier.level));
    TraitModel.update(
        context, TraitModel.replaceModifier(trait, index: index, modifier: m));
  }
}
