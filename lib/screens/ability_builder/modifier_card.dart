import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/common.dart';
import '../../widgets/gurps_icons.dart';
import 'modifier_name_textfield.dart';
import 'modifier_percentage_textfield.dart';

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

    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent value) {
        if (value.data is RawKeyEventDataAndroid) {
          var d = value.data as RawKeyEventDataAndroid;
          print('${d}');
          if (d.keyCode == 9) // TAB key
          {
            // switch focus
          }
        }
      },
      child: Row(
        children: <Widget>[
          Expanded(
              child: ModifierNameTextField(
                  modifier: model, trait: trait, index: index)),
          Container(
            margin: EdgeInsets.only(left: 16.0),
            width: 100.0,
            child: ModifierPercentageTextField(
                model: model, trait: trait, index: index),
          ),
        ],
      ),
    );
  }
}
