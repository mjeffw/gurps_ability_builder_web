import 'package:flutter_web/material.dart';

import '../model/trait_model.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({
    Key key,
    @required this.trait,
    @required this.index,
  }) : super(key: key);

  final TraitModel trait;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.cancel,
        color: Colors.grey,
      ),
      onTap: () {
        TraitModel.update(
          context,
          TraitModel.replaceModifier(
            trait,
            index: index,
            modifier: BlankModifier(),
          ),
        );
      },
    );
  }
}
