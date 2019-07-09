import 'package:flutter_web/material.dart';

import '../../model/trait_model.dart';
import '../../widgets/clear_button.dart';

class VariableModifierPanel extends StatelessWidget {
  final int index;

  const VariableModifierPanel({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);

    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: ClearButton(trait: trait, index: index),
        ),
      ],
    );
  }
}
