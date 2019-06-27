import 'dart:html';

import 'package:flutter_web/material.dart';
import 'package:flutter_web/painting.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import '../../model/trait_model.dart';
import '../../widgets/common.dart';
import '../../widgets/gurps_icons.dart';
import '../../widgets/type_ahead_textfield.dart';

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
          child: _nameField(model, context, trait),
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

  Widget _nameField(Modifier model, BuildContext context, TraitModel trait) {
    // return AutoCompleteTextView(
    //   tfTextDecoration: const InputDecoration(
    //     labelText: 'Modifier Name',
    //     filled: true,
    //   ),
    //   onValueChanged: (text) {
    //     Modifier m = cloneModel(model, name: text);
    //     TraitModel.update(context,
    //         TraitModel.updateModifier(trait, index: index, modifier: m));
    //   },
    //   controller: TextEditingController(text: model.name),
    //   getSuggestionsMethod: (pattern) {
    //     print(pattern);
    //     var all = modifiers.fetchEntries().where((it) {
    //       var itLowerCase = it.key.toLowerCase();
    //       print(itLowerCase);
    //       return itLowerCase.startsWith(pattern.toString().toLowerCase());
    //     });
    //     var list = all.map((it) => it.key).toList();
    //     print('matches: ${list.length}');
    //     return list;
    //   },
    //   suggestionsApiFetchDelay: 500,
    // );
    return TypeAheadField<MapEntry<String, ModifierFactory>>(
      textFieldConfiguration: TextFieldConfiguration(
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
          }),
      suggestionsCallback: (pattern) async {
        return await _suggestionsCallback(pattern);
      },
      itemBuilder: (context, suggestion) {
        print(suggestion);
        return ListTile(title: Text(suggestion.key));
      },
      onSuggestionSelected: (suggestion) {
        // TODO modify Modifier to match
      },
    );
  }

  List<MapEntry<String, ModifierFactory>> _suggestionsCallback(String pattern) {
    print(pattern);
    var fetchEntries = modifiers.fetchEntries();
    print('total entries = ${fetchEntries.length}');
    var list = fetchEntries.where((test) {
      return test.key.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    print('potential matches = ${list.length}');
    return list;
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
