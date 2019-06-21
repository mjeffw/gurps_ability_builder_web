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

    var label = model.hasLevels ? 'Cost Per Level' : 'Cost';

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: label, filled: true),
            onChanged: (text) {
              TraitModel.update(
                  context,
                  TraitModel.copyOf(model,
                      baseCost: text.isEmpty ? 0 : int.parse(text)));
            },
            keyboardType: TextInputType.number,
            controller: TextEditingController(
              text: model.baseCost.toString(),
            ),
          ),
        ),
        PlatformCheckbox(
            onChanged: (hasLevels) {
              TraitModel.update(
                  context, TraitModel.copyOf(model, hasLevels: hasLevels));
            },
            hasLevels: model.hasLevels),
        Expanded(
          child: Visibility(
            visible: model.hasLevels,
            child: TextField(
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(labelText: label, filled: true),
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
