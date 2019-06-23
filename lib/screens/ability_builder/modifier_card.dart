import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';
import 'package:gurps_ability_builder_web/widgets/platform_checkbox.dart';
import 'package:gurps_modifiers/src/modifier.dart';

class ModifierCard extends StatelessWidget {
  final Modifier _modifier;

  ModifierCard(this._modifier);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);
    final int index = model.modifiers.indexOf(_modifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildContainer(
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: TextEditingController(text: _modifier.name),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        suffixIcon: IconButton(
                          alignment: Alignment.bottomCenter,
                          icon: Icon(Icons.arrow_drop_down_circle),
                          onPressed: () {
                            print('pressed');
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 36.0,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            buildContainer(
              Row(
                children: <Widget>[
                  PlatformCheckbox(
                    value: _modifier.isAttackModifier,
                    prompt: 'Attack Modifier',
                    onChanged: null,
                  ),
                  Expanded(
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        labelText: 'Value',
                        filled: true,
                        suffix: Text('%'),
                      ),
                      controller: TextEditingController(
                          text: _modifier.value.toString()),
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
