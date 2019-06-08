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
  String _value;
  bool _hasLevels = false;

  get _costLabelText => _hasLevels ? 'Cost Per Level' : 'Cost';

  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a `GlobalKey<FormState>`, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Trait name',
                  filled: true,
                ),
                onChanged: (value) {
                  setState(
                    () {
                      if (value.isNotEmpty) {
                        _value = value;
                      }
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: _costLabelText,
                        filled: true,
                      ),
                    ),
                  ),
                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        _hasLevels = !_hasLevels;
                      });
                    },
                    value: _hasLevels,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: const Text('Has Levels'),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: _hasLevels,
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'Level',
                          filled: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: <Widget>[
    //     TextField(
    //         decoration: InputDecoration(
    //           filled: true,
    //           labelText:
    //               'Trait (An advantage, disadvantage, attribute, secondary characteristic, quirk, skill, or technique)',
    //         ),
    //         onChanged: (text) {
    //           _value = text;
    //         }),
    //     Text('Has Levels'),
    //     Checkbox(
    //       onChanged: (bool value) {
    //         setState(() {
    //           _hasLevels = !_hasLevels;
    //         });
    //       },
    //       value: _hasLevels,
    //     )
    //   ],
    // );
  }
}
