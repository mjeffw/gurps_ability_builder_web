import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import 'modifier_level_textfield.dart';
import 'modifier_name_textfield.dart';

class LeveledModifierPanel extends StatelessWidget {
  const LeveledModifierPanel({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier modifier = trait.modifiers[index];

    return Column(
      // this.baseValue = 0,
      // this.valuePerLevel,
      // int maxLevel,
      children: [
        Row(
          children: <Widget>[
            Expanded(
                child: ModifierNameTextField(
                    modifier: modifier, trait: trait, index: index)),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              width: 100.0,
              child: ModifierLevelTextField(
                  model: modifier, trait: trait, index: index),
            ),
          ],
        ),
      ],
    );
  }
}
