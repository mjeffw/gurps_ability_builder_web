import 'package:flutter_web/io.dart';
import 'package:flutter_web/material.dart';

class PlatformCheckbox extends StatelessWidget {
  const PlatformCheckbox({
    Key key,
    @required this.onChanged,
    @required this.hasLevels,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
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
