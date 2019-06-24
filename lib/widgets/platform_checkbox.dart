import 'package:flutter_web/io.dart';
import 'package:flutter_web/material.dart';

class PlatformCheckbox extends StatelessWidget {
  const PlatformCheckbox({
    Key key,
    @required this.onChanged,
    @required this.value,
    @required this.prompt,
  }) : super(key: key);

  final ValueChanged<bool> onChanged;
  final bool value;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    var checkbox = // Switch(onChanged: onChanged, value: value);
     (Platform.isIOS || Platform.isMacOS)
        ? Switch(onChanged: onChanged, value: value)
        : Checkbox(onChanged: onChanged, value: value);

    return Row(
      children: <Widget>[
        checkbox,
        InkWell(
          onTap: () {
            onChanged.call(!value);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(prompt),
          ),
        ),
      ],
    );
  }
}
