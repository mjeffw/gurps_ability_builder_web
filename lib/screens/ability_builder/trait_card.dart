import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';

import 'trait_cost.dart';
import 'trait_name_field.dart';

class TraitCard extends StatelessWidget {
  const TraitCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Trait: ${model.name} [${model.unmodifiedCost}]',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            buildContainer(TraitNameField()),
            buildContainer(TraitCost()),
          ],
        ),
      ),
    );
  }
}
