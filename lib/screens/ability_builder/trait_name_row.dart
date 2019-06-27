import 'package:flutter_web/material.dart';

import '../../model/trait_model.dart';

class TraitNameRow extends StatelessWidget {
  const TraitNameRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);
    final label = model.hasLevels ? 'Per Level' : 'Cost';

    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              labelText: 'Trait name',
              filled: true,
            ),
            onChanged: (name) {
              TraitModel.update(context, TraitModel.copyOf(model, name: name));
            },
            controller: TextEditingController(text: model.name),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          width: 100.0,
          child: TextField(
            textAlign: TextAlign.right,
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            decoration: InputDecoration(labelText: label, filled: true),
            onChanged: (text) {
              TraitModel.update(
                context,
                TraitModel.copyOf(
                  model,
                  baseCost: text.isEmpty ? 0 : int.parse(text),
                ),
              );
            },
            keyboardType: TextInputType.number,
            controller: TextEditingController(
              text: model.baseCost.toString(),
            ),
          ),
        )
      ],
    );
  }
}
