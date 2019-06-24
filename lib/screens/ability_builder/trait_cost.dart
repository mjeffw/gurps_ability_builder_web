import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/model/trait_model.dart';
import 'package:gurps_ability_builder_web/widgets/platform_checkbox.dart';

class TraitCost extends StatelessWidget {
  const TraitCost({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return Row(
      children: <Widget>[
        Expanded(child: Container()),
        PlatformCheckbox(
            onChanged: (hasLevels) {
              TraitModel.update(
                  context, TraitModel.copyOf(model, hasLevels: hasLevels));
            },
            value: model.hasLevels,
            prompt: 'Has Levels'),
        Visibility(
          visible: model.hasLevels,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Container(
            margin: EdgeInsets.only(left: 16.0),
            width: 140.0,
            child: TextField(
              textAlign: TextAlign.right,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: 'Levels', filled: true),
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                text: model.numberOfLevels.toString(),
              ),
              onChanged: (text) {
                TraitModel.update(
                    context,
                    TraitModel.copyOf(model,
                        numberOfLevels: text.isEmpty ? 0 : int.parse(text)));
              },
            ),
          ),
        ),
      ],
    );
  }
}
