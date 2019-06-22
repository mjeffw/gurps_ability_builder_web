import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import 'modifier_card.dart';
import 'trait_card.dart';

const _widescreenWidthMinimum = 600.0;

class AbilityBuilder extends StatelessWidget {
  static String routeName = '/abilityBuilder';

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: const TraitModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ability Builder"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AbilityPanel(),
        ),
      ),
    );
  }
}

///
/// AbilityPanel may be able to become a StatelessWidget since the model has
///  been refactored out.
///
class AbilityPanel extends StatefulWidget {
  @override
  _AbilityPanelState createState() => _AbilityPanelState();
}

class _AbilityPanelState extends State<AbilityPanel> {
  double _width;
  bool _isWideScreen = false;

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    double width = MediaQuery.of(context).size.width;
    setState(() {
      _width = width;
      _isWideScreen = _width > _widescreenWidthMinimum;
    });

    return Form(
      key: _formKey,
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: <Widget>[
            Text('${_width.toString()}:$_isWideScreen'),
            _traitCard(),
            for (var modifier in model.modifiers) _modifierCard(modifier),
            _addModifierButton(model, context),
          ],
        ),
      ),
    );
  }

  Widget _traitCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TraitCard(),
    );
  }

  Widget _modifierCard(Modifier modifier) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ModifierCard(modifier));
  }

  Widget _addModifierButton(TraitModel model, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FloatingActionButton.extended(
          onPressed: () {
            TraitModel.update(
                context, TraitModel.addModifier(model, Modifier(name: 'Foo')));
          },
          label: Text('Add Modifier'),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}
