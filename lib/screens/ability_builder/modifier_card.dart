import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';
import 'package:gurps_ability_builder_web/widgets/gurps_icons.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

class ModifierCard extends StatelessWidget {
  final int index;

  ModifierCard(this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _titleRow(context),
            ..._contents(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _contents(BuildContext context) =>
      <Widget>[buildContainer(_buildNameRow(context))];

  Widget _buildNameRow(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            autofocus: true,
            controller: TextEditingController(text: model.name),
            decoration: const InputDecoration(
              labelText: 'Modifier Name',
              filled: true,
            ),
            onChanged: (text) {
              Modifier m = cloneModel(model, name: text);
              TraitModel.update(context,
                  TraitModel.updateModifier(trait, index: index, modifier: m));
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          width: 100.0,
          child: TextField(
            onChanged: (text) {
              Modifier m = cloneModel(model, percentage: int.parse(text));
              TraitModel.update(context,
                  TraitModel.updateModifier(trait, index: index, modifier: m));
            },
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              labelText: 'Value',
              filled: true,
              suffix: Text('%'),
            ),
            controller:
                TextEditingController(text: model.percentage.toString()),
          ),
        ),
      ],
    );
  }

  Row _titleRow(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];

    return Row(
      children: <Widget>[
        IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.cancel, color: Colors.red),
          onPressed: () {
            TraitModel.update(
                context, TraitModel.removeModifier(trait, index: index));
          },
        ),
        Text(
          '${model.name.isEmpty ? "Modifier: " : ""}${model.name} (${model.percentage})',
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
