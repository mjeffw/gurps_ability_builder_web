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
          child: modifierNameTextField(model, trait),
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

  ModifierNameTextField modifierNameTextField(
      Modifier model, TraitModel trait) {
    print(
        'new ModifierNameTextField(modifier: $model, trait: $trait, index: $index, model.name = ${model.name})');
    return ModifierNameTextField(modifier: model, trait: trait, index: index);
  }

  Row _titleRow(BuildContext context) {
    final TraitModel trait = TraitModel.of(context);
    final Modifier model = trait.modifiers[index];

    return Row(
      children: <Widget>[
        Text(
          '${model.name.isEmpty ? "Modifier " : ""}${model.name} (${model.percentage}%)',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
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
                context, TraitModel.removeModifier(trait, index: index));
          },
        ),
      ],
    );
  }
}

class ModifierNameTextField extends StatefulWidget {
  ModifierNameTextField({
    Key key,
    @required this.index,
    @required this.trait,
    @required this.modifier,
  }) : super(key: key);

  final TraitModel trait;
  final Modifier modifier;
  final int index;

  @override
  _ModifierNameTextFieldState createState() =>
      _ModifierNameTextFieldState(modifier.name);
}

class _ModifierNameTextFieldState extends State<ModifierNameTextField> {
  TextEditingController controller;

  _ModifierNameTextFieldState(String name)
      : controller = TextEditingController(text: name) {
    print('new _ModifierNameTextFieldState(name: $name');
    print('${controller.hashCode}');
  }

  @override
  void didUpdateWidget(ModifierNameTextField oldWidget) {
    print('_ModifierNameTextFieldState.didUpdateWidget');
    super.didUpdateWidget(oldWidget);
    controller.text = widget.modifier.name;
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Modifier Name',
          filled: true,
        ),
        onEditingComplete: () {
          _updateModifier();
        },
        onSubmitted: (text) {
          _updateModifier();
        },
      ),
      suggestionsCallback: (pattern) async {
        return await _suggestionsCallback(pattern);
      },
      itemBuilder: (context, suggestion) {
        print(suggestion);
        return ListTile(title: Text(suggestion));
      },
      onSuggestionSelected: (suggestion) {
        Modifier m = modifiers.fetch(suggestion);
        TraitModel.update(
            context,
            TraitModel.updateModifier(widget.trait,
                index: widget.index, modifier: m));
      },
    );
  }

  void _updateModifier() {
    print('updateModifier');
    Modifier m = cloneModel(widget.modifier, name: controller.text);
    TraitModel.update(
        context,
        TraitModel.updateModifier(widget.trait,
            index: widget.index, modifier: m));
  }

  List<String> _suggestionsCallback(String pattern) {
    var fetchKeys = modifiers.fetchKeys();
    var list = fetchKeys.where((test) {
      return test.toLowerCase().startsWith(pattern.toLowerCase());
    }).toList();
    return list;
  }
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
