import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/screens/ability_builder/trait_cost.dart';
import 'package:gurps_ability_builder_web/screens/ability_builder/trait_name_field.dart';

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
              child: TraitCard(),
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Trait: ${model.name} [${model.unmodifiedCost}]',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            _buildContainer(TraitNameField()),
            _buildContainer(TraitCost()),
          ],
        ),
      ),
    );
  }
}
