import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

import 'modifier_model.dart';

@immutable
class TraitModel extends Trait {
  const TraitModel(
      {String name,
      int baseCost,
      bool hasLevels,
      int numberOfLevels,
      List<Modifier> modifiers})
      : super(
            name: name ?? '',
            baseCost: baseCost ?? 0,
            hasLevels: hasLevels ?? false,
            numberOfLevels: numberOfLevels ?? 0,
            modifiers: modifiers);

  factory TraitModel.copyOf(TraitModel original,
      {String name, int baseCost, bool hasLevels, int numberOfLevels}) {
    return TraitModel(
        baseCost: baseCost ?? original.baseCost,
        name: name ?? original.name,
        hasLevels: hasLevels ?? original.hasLevels,
        numberOfLevels: numberOfLevels ?? original.numberOfLevels);
  }

  factory TraitModel.addModifier(TraitModel model, Modifier modifier) {
    return TraitModel(
        baseCost: model.baseCost,
        hasLevels: model.hasLevels,
        name: model.name,
        numberOfLevels: model.numberOfLevels,
        modifiers:
            _addModifierTo(model.modifiers, SimpleModifier(name: 'Foo')));
  }

  factory TraitModel.updateModifier(TraitModel model,
      {int index, Modifier modifier}) {
    var list = List<Modifier>.of(model.modifiers);
    list[index] = modifier;
    return TraitModel(
        baseCost: model.baseCost,
        hasLevels: model.hasLevels,
        name: model.name,
        numberOfLevels: model.numberOfLevels,
        modifiers: list);
  }

  @override
  String toString() =>
      'Trait(name: $name, baseCost: $baseCost, hasLevels: $hasLevels, '
      'numberOfLevels: $numberOfLevels)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final TraitModel otherModel = other;
    return otherModel.baseCost == this.baseCost &&
        otherModel.hasLevels == this.hasLevels &&
        otherModel.name == this.name &&
        otherModel.numberOfLevels == this.numberOfLevels &&
        listEquals(otherModel.modifiers, this.modifiers);
  }

  @override
  int get hashCode =>
      this.baseCost.hashCode ^
      this.modifiers.map((m) => m.hashCode).reduce((a, b) => a ^ b);

  static TraitModel of(BuildContext context) {
    final _TraitModelBindingScope scope =
        context.inheritFromWidgetOfExactType(_TraitModelBindingScope);
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, TraitModel newModel) {
    final _TraitModelBindingScope scope =
        context.inheritFromWidgetOfExactType(_TraitModelBindingScope);
    scope.modelBindingState.updateModel(newModel);
  }

  ModifierModel modifierModel(int index) {
    return ModifierModel(
        name: '',
        isAttackModifier: false,
        percentage: 0,
        onUpdate: (m) {
          TraitModel.updateModifier(this, index: index, modifier: m);
        });
  }
}

List<Modifier> _addModifierTo(List<Modifier> list, Modifier mod) {
  var mods = List<Modifier>.from(list, growable: true);
  mods.add(mod);
  return List.unmodifiable(mods);
}

class _TraitModelBindingScope extends InheritedWidget {
  _TraitModelBindingScope({
    Key key,
    @required this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);
  final _TraitModelBindingState modelBindingState;
  @override
  bool updateShouldNotify(_TraitModelBindingScope oldWidget) => true;
}

class TraitModelBinding extends StatefulWidget {
  TraitModelBinding({
    Key key,
    this.initialModel = const TraitModel(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);
  final TraitModel initialModel;
  final Widget child;
  _TraitModelBindingState createState() => _TraitModelBindingState();
}

class _TraitModelBindingState extends State<TraitModelBinding> {
  TraitModel currentModel;
  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(TraitModel newModel) {
    if (newModel != currentModel) {
      setState(() {
        print(newModel);
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _TraitModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
