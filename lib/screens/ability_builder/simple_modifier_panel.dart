import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';

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
          child: Text(modifier.name),
          // modifier: modifier, trait: trait, index: index),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          width: 100.0,
          child: Text(
            '${modifier.percentage}%',
            style: TextStyle(height: 2.0),
          ),
        ),
      ],
    );
  }
}
