import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/common.dart';
import '../../widgets/gurps_icons.dart';
import 'modifier_name_textfield.dart';

var titleStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

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

  Widget _titleRow(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];
    final title = model.name.isEmpty ? 'Modifier ' : '';

    return Row(
      children: <Widget>[
        Text('$title${model.name} (${model.percentage}%)', style: titleStyle),
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
              visible: model.isAttackModifier,
              child: Icon(GurpsIcons.gun),
            ),
          ),
        ),
        IconButton(
          alignment: Alignment.centerLeft,
          icon: Icon(Icons.cancel, color: Colors.red),
          onPressed: () {
            TraitModel.update(
              context,
              TraitModel.removeModifier(trait, index: index),
            );
          },
        ),
      ],
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
            child: ModifierNameTextField(
                modifier: model, trait: trait, index: index)),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          width: 100.0,
          child: TextField(
            onChanged: (text) {
              Modifier m = cloneModel(model, percentage: int.parse(text));
              TraitModel.update(context,
                  TraitModel.replaceModifier(trait, index: index, modifier: m));
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
}
