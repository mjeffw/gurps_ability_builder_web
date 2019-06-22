import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

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
        modifiers: addModifierTo(model.modifiers, Modifier(name: 'Foo')));
  }

  static List<Modifier> addModifierTo(List<Modifier> list, Modifier mod) {
    var mods = List<Modifier>.from(list, growable: true);
    mods.add(mod);
    return mods;
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
        listEquals(otherModel.modifiers, this.modifiers);
  }

  @override
  int get hashCode =>
      this.baseCost.hashCode ^
      this.modifiers.map((m) => m.hashCode).reduce((a, b) => a ^ b);

  static TraitModel of(BuildContext context) {
    final _ModelBindingScope scope =
        context.inheritFromWidgetOfExactType(_ModelBindingScope);
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, TraitModel newModel) {
    final _ModelBindingScope scope =
        context.inheritFromWidgetOfExactType(_ModelBindingScope);
    scope.modelBindingState.updateModel(newModel);
  }
}

class _ModelBindingScope extends InheritedWidget {
  _ModelBindingScope({
    Key key,
    @required this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);
  final _ModelBindingState modelBindingState;
  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key key,
    this.initialModel = const TraitModel(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);
  final TraitModel initialModel;
  final Widget child;
  _ModelBindingState createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
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
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
