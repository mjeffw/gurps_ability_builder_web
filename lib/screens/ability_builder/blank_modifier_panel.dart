import 'package:flutter_web/material.dart';

import '../../model/trait_model.dart';
import 'modifier_name_textfield.dart';
import 'modifier_percentage_textfield.dart';

class BlankModifierPanel extends StatelessWidget {
  const BlankModifierPanel({
    Key key,
    @required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final BlankModifier modifier = trait.modifiers[index] as BlankModifier;
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
          child: InkWell(
            child: Icon(
              Icons.cancel,
              color: Colors.blueAccent,
            ),
            onTap: () {
              TraitModel.update(
                context,
                TraitModel.replaceModifier(
                  trait,
                  index: index,
                  modifier: BlankModifier(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
