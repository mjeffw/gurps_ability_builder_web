import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/screens/ability_builder/trait_name_field.dart';

import 'trait_cost.dart';

const _widescreenWidthMinimum = 600.0;

class AbilityBuilder extends StatelessWidget {
  static String routeName = '/abilityBuilder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ability Builder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AbilityPanel(),
      ),
    );
  }
}

class AbilityPanel extends StatefulWidget {
  @override
  _AbilityPanelState createState() => _AbilityPanelState();
}

class _AbilityPanelState extends State<AbilityPanel> {
  double _width;
  bool _hasLevels = false;
  bool _isWideScreen = false;
  String _name;

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    setState(() {
      _width = width;
      _isWideScreen = _width > _widescreenWidthMinimum;
    });

    var children2 = <Widget>[
      Text('${_width.toString()}:$_isWideScreen'),
      _buildContainer(TraitNameField(onChanged: (value) {
        setState(() {
          _name = value;
        });
      })),
      _buildContainer(
        TraitCost(
          isWideScreen: false,
          hasLevels: _hasLevels,
          onChanged: (bool value) {
            setState(() {
              _hasLevels = value;
            });
          },
        ),
      )
    ];

    return Form(
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: children2,
        ),
      ),
    );
  }

  Container _buildContainer(Widget widget) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      alignment: Alignment.bottomLeft,
      child: widget,
    );
  }
}
