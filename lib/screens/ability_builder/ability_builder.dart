import 'package:flutter_web/material.dart';

import '../../model/trait_model.dart';
import 'modifier_card.dart';
import 'trait_card.dart';

const _widescreenWidthMinimum = 600.0;

class AbilityBuilder extends StatelessWidget {
  static String routeName = '/abilityBuilder';

  @override
  Widget build(BuildContext context) {
    return TraitModelBinding(
      initialModel: const TraitModel(),
      child: AbilityPanel(),
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

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    double width = MediaQuery.of(context).size.width;
    setState(() {
      _width = width;
      _isWideScreen = _width > _widescreenWidthMinimum;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Ability Builder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            children: <Widget>[
              Text('${_width.toString()}:$_isWideScreen'),
              TraitCard(),
              for (var index in model.modifiers.asMap().keys)
                ModifierCard(index),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          TraitModel.update(context, TraitModel.addModifier(model));
        },
        label: Text('Add Modifier'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
