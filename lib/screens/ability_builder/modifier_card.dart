import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/gurps_icons.dart';
import 'blank_modifier_panel.dart';
import 'leveled_modifier_panel.dart';
import 'simple_modifier_panel.dart';
import 'variable_modifier_panel.dart';

var titleStyle = TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);

class ModifierCard extends StatelessWidget {
  final int index;

  ModifierCard(this.index);

  @override
  Widget build(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    return Card(
      child: Column(
        children: <Widget>[
          _closeIcon(context, trait),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _closeIcon(BuildContext context, TraitModel trait) {
    return Row(
      children: <Widget>[
        Spacer(),
        InkWell(
          child: Icon(Icons.clear, color: Colors.grey),
          onTap: () {
            TraitModel.update(
              context,
              TraitModel.removeModifier(trait, index: index),
            );
          },
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _titleRow(context),
          _contents(context, index),
        ],
      ),
    );
  }

  Widget _titleRow(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];
    final title = model.name.isEmpty ? 'Modifier ' : '';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Padding(
            child: Text(
              '$title${model.name}',
              style: titleStyle,
              maxLines: 2,
            ),
            padding: EdgeInsets.only(right: 8.0),
          ),
        ),
        Visibility(
          visible: model.isAttackModifier,
          child: Padding(
              child: Icon(GurpsIcons.gun),
              padding: EdgeInsets.only(right: 8.0)),
        ),
        Text(
          '(${model.percentage}%)',
          style: titleStyle,
        ),
      ],
    );
  }

  Widget _contents(BuildContext context, int index) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];

    if (model is BlankModifier) {
      return BlankModifierPanel(index: index);
    } else if (model is SimpleModifier) {
      return SimpleModifierPanel(index: index);
    } else if (model is LeveledModifier) {
      return LeveledModifierPanel(index: index);
    } else {
      return VariableModifierPanel(index: index);
    }
  }
}
