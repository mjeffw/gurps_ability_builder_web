import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/widgets/common.dart';
import 'package:gurps_ability_builder_web/widgets/platform_checkbox.dart';

class TraitCost extends StatelessWidget {
  final bool hasLevels;
  final bool isWideScreen;
  get _costLabelText => hasLevels ? 'Cost Per Level' : 'Cost';
  final OnChanged<bool> onChanged;

  const TraitCost(
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
          child: getStandardTextField(_costLabelText),
        ),
        PlatformCheckbox(onChanged: onChanged, hasLevels: hasLevels),
        Expanded(
          child: Visibility(
            visible: hasLevels,
            child: getStandardTextField('Level'),
          ),
        ),
      ],
    );
  }
}
