import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/widgets/clear_button.dart';

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

    return Column(
      // this.baseValue = 0,
      // this.valuePerLevel,
      // int maxLevel,
      children: [
        Row(
          children: <Widget>[
            Expanded(child: ModifierNameTextField(trait: trait, index: index)),
            Container(
              margin: EdgeInsets.only(left: 8.0),
              width: 250.0,
              child: ModifierLevelTextField(trait: trait, index: index),
            ),
            Container(
              margin: EdgeInsets.only(left: 8.0),
              child: ClearButton(trait: trait, index: index),
            )
          ],
        ),
      ],
    );
  }
}
