import 'package:flutter_web/io.dart';
import 'package:flutter_web/material.dart';

typedef void OnChanged<T>(T value);
const _widescreenWidthMinimum = 600.0;

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
      _buildContainer(_TraitNameField(onChanged: (value) {
        setState(() {
          _name = value;
        });
      })),
      _buildContainer(
        _TraitCost(
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

class _TraitCost extends StatelessWidget {
  final bool hasLevels;
  final bool isWideScreen;
  get _costLabelText => hasLevels ? 'Cost Per Level' : 'Cost';
  final OnChanged<bool> onChanged;

  const _TraitCost(
      {Key key,
      @required this.onChanged,
      @required this.hasLevels,
      @required this.isWideScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _getStandardTextField(_costLabelText),
        ),
        PlatformCheckbox(onChanged: onChanged, hasLevels: hasLevels),
        Expanded(
          child: Visibility(
            visible: hasLevels,
            child: _getStandardTextField('Level'),
          ),
        ),
      ],
    );
  }
}

TextField _getStandardTextField(String text) {
  return TextField(decoration: InputDecoration(labelText: text, filled: true));
}

class PlatformCheckbox extends StatelessWidget {
  const PlatformCheckbox({
    Key key,
    @required this.onChanged,
    @required this.hasLevels,
  }) : super(key: key);

  final OnChanged<bool> onChanged;
  final bool hasLevels;

  @override
  Widget build(BuildContext context) {
    var checkbox = (Platform.isIOS || Platform.isMacOS)
        ? Switch(onChanged: onChanged, value: hasLevels)
        : Checkbox(onChanged: onChanged, value: hasLevels);

    return Row(
      children: <Widget>[
        checkbox,
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: const Text('Has Levels'),
        ),
      ],
    );
  }
}

class _TraitNameField extends StatelessWidget {
  final OnChanged onChanged;

  const _TraitNameField({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        labelText: 'Trait name',
        filled: true,
      ),
      onChanged: onChanged,
    );
  }
}
