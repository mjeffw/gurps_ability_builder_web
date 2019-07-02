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

enum ModifierType { Simple, Leveled, Variable }

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
            _contents(context, index),
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
      // model is VariableModifier
      return VariableModifierPanel(index: index);
    }
  }
}
