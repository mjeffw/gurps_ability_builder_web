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
  int _cost = 5;
  int _costPerLevel = 0;
  String _name = 'test';

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

    return Form(
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: <Widget>[
            Text('${_width.toString()}:$_isWideScreen'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TraitCard(
                hasLevels: _hasLevels,
                cost: _cost,
                costPerLevel: _costPerLevel,
                name: _name,
                onCostChanged: (cost) {
                  setState(() {
                    this._cost = cost;
                  });
                },
                onNameChanged: (name) {
                  setState(() {
                    this._name = name;
                  });
                },
                onCostPerLevelChanged: (costPerLevel) {
                  setState(() {
                    _costPerLevel = costPerLevel;
                  });
                },
                onHasLevelsChanged: (hasLevels) {
                  setState(() {
                    _hasLevels = hasLevels;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton.extended(
                  onPressed: () {},
                  label: Text('Add Modifier'),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container _buildContainer(Widget widget) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    alignment: Alignment.bottomLeft,
    child: widget,
  );
}

class TraitCard extends StatelessWidget {
  const TraitCard({
    Key key,
    @required this.hasLevels,
    @required this.cost,
    @required this.costPerLevel,
    @required this.name,
    @required this.onNameChanged,
    @required this.onCostChanged,
    @required this.onHasLevelsChanged,
    @required this.onCostPerLevelChanged,
  }) : super(key: key);

  final bool hasLevels;
  final String name;
  final int cost;
  final int costPerLevel;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<int> onCostChanged;
  final ValueChanged<int> onCostPerLevelChanged;
  final ValueChanged<bool> onHasLevelsChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Trait',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            _buildContainer(
                TraitNameField(value: name, onChanged: onNameChanged)),
            _buildContainer(
              TraitCost(
                cost: cost,
                costPerLevel: costPerLevel,
                isWideScreen: false,
                hasLevels: hasLevels,
                onChanged: onHasLevelsChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
