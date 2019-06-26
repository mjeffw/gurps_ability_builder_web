import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_ability_builder_web/model/modifier_model.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';
import 'package:gurps_ability_builder_web/widgets/gurps_icons.dart';
import 'package:gurps_ability_builder_web/widgets/platform_checkbox.dart';

class ModifierCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ModifierModel model = ModifierModel.of(context);
    final TraitModel trait = TraitModel.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Modifier: ${model.name} (${model.percentage})',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: model.isAttackModifier,
                      child: Icon(GurpsIcons.gun),
                    ),
                  ),
                )
              ],
            ),
            buildContainer(
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: model.name),
                      decoration: InputDecoration(
                        labelText: 'Modifier Name',
                        suffixIcon: IconButton(
                          alignment: Alignment.bottomCenter,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          onPressed: () {
                            print('pressed');
                          },
                        ),
                      ),
                      onChanged: (text) {
                        ModifierModel.update(
                          context,
                          ModifierModel.copyOf(model, name: text),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    alignment: Alignment.topRight,
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 36.0,
                    ),
                    onPressed: () {
                      TraitModel.update(context,
                          TraitModel.removeModifier(trait, index: model.index));
                    },
                  )
                ],
              ),
            ),
            buildContainer(
              Row(
                children: <Widget>[
                  PlatformCheckbox(
                    value: model.isAttackModifier,
                    prompt: 'Attack Modifier',
                    onChanged: (b) {
                      ModifierModel.update(context,
                          ModifierModel.copyOf(model, isAttackModifier: b));
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        ModifierModel.update(
                            context,
                            ModifierModel.copyOf(model,
                                percentage: int.parse(text)));
                      },
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        labelText: 'Value',
                        filled: true,
                        suffix: Text('%'),
                      ),
                      controller: TextEditingController(
                          text: model.percentage.toString()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
