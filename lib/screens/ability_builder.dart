import 'package:flutter_web/material.dart';

class AbilityBuilder extends StatelessWidget {
  static String routeName = '/abilityBuilder';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ability Builder"),
      ),
      body: Padding(
        child: AbilityPanel(),
        padding: EdgeInsets.all(10.0),
      ),
    );
  }
}

class AbilityPanel extends StatefulWidget {
  @override
  _AbilityPanelState createState() => _AbilityPanelState();
}

class _AbilityPanelState extends State<AbilityPanel> {
  String _value;

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              // hintText: 'Trait Name',
              labelText: 'Trait Name',
            ),
            onChanged: (text) {
              _value = text;
            },
          )
        ],
      ),
    );
  }
}
