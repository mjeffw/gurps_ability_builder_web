import 'package:flutter_web/cupertino.dart';

import '../../model/trait_model.dart';

class TraitTextRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TraitModel model = TraitModel.of(context);

    return Row(
      children: <Widget>[
        Text(
          'Test',
          softWrap: true,
        ),
      ],
    );
  }
}
