import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';
import 'package:gurps_ability_builder_web/widgets/gurps_icons.dart';
import 'package:gurps_ability_builder_web/widgets/platform_checkbox.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

class ModifierCard extends StatelessWidget {
  final int index;

  ModifierCard(this.index);

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];

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
                        Modifier m = cloneModel(model, name: text);
                        print('Modifier: $m');
                        TraitModel.update(
                            context,
                            TraitModel.updateModifier(trait,
                                index: index, modifier: m));
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
                          TraitModel.removeModifier(trait, index: index));
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
                      Modifier m = cloneModel(model, isAttackModifier: b);
                      TraitModel.update(
                          context,
                          TraitModel.updateModifier(trait,
                              index: index, modifier: m));
                    },
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (text) {
                        Modifier m =
                            cloneModel(model, percentage: int.parse(text));
                        TraitModel.update(
                            context,
                            TraitModel.updateModifier(trait,
                                index: index, modifier: m));
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

  Modifier cloneModel(Modifier model,
      {String name, bool isAttackModifier, int percentage}) {
    Modifier m;
    if (model is SimpleModifier) {
      return SimpleModifier.copyOf(model,
          value: percentage, name: name, isAttackModifier: isAttackModifier);
    }
    return m;
  }
}
