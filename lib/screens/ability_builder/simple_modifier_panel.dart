import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/clear_button.dart';
import 'modifier_name_textfield.dart';
import 'modifier_percentage_textfield.dart';

class SimpleModifierPanel extends StatelessWidget {
  const SimpleModifierPanel({
    Key key,
    this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final SimpleModifier modifier = trait.modifiers[index] as SimpleModifier;
    return Row(
      children: <Widget>[
        Expanded(
          child: ModifierNameTextField(
              modifier: modifier, trait: trait, index: index),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          width: 100.0,
          child: ModifierPercentageTextField(
              model: modifier, trait: trait, index: index),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: ClearButton(trait: trait, index: index),
        )
      ],
    );
  }
}
