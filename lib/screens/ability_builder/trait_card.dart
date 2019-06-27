import 'package:flutter_web/material.dart';

import '../../model/trait_model.dart';
import '../../widgets/common.dart';
import 'trait_level_cost_row.dart';
import 'trait_name_row.dart';

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
              '${model.name.isEmpty ? "Trait " : ""}${model.name} [${model.unmodifiedCost}]',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            buildContainer(TraitNameRow()),
            buildContainer(TraitLevelCostRow()),
          ],
        ),
      ),
    );
  }
}
