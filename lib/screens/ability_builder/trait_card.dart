import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';

import 'trait_cost.dart';
import 'trait_name_field.dart';

Container _buildContainer(Widget widget) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    alignment: Alignment.bottomLeft,
    child: widget,
  );
}

class TraitCard extends StatelessWidget {
  const TraitCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Trait: ${model.name} [${model.unmodifiedCost}]',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            _buildContainer(TraitNameField()),
            _buildContainer(TraitCost()),
          ],
        ),
      ),
    );
  }
}
