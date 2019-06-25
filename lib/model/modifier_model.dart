import 'package:flutter_web/material.dart';
import 'package:gurps_modifiers/gurps_modifiers.dart';

@immutable
class ModifierModel extends SimpleModifier {
  final ValueChanged<ModifierModel> onUpdate;
  const ModifierModel(
      {int percentage, String name, bool isAttackModifier, this.onUpdate})
      : super(
            percentage: percentage,
            name: name,
            isAttackModifier: isAttackModifier);

  factory ModifierModel.copyOf(ModifierModel original,
      {String name, int percentage, bool isAttackModifier}) {
    return ModifierModel(
        name: name ?? original.name,
        percentage: percentage ?? original.percentage,
        isAttackModifier: isAttackModifier,
        onUpdate: original.onUpdate);
  }

  @override
  String toString() =>
      'Modifier(name: $name, percentage: $percentage, isAttackModifier: $isAttackModifier)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final ModifierModel otherModel = other;
    return otherModel.percentage == this.percentage &&
        otherModel.isAttackModifier == this.isAttackModifier &&
        otherModel.name == this.name;
  }

  @override
  int get hashCode =>
      percentage.hashCode ^ name.hashCode ^ isAttackModifier.hashCode;

  static ModifierModel of(BuildContext context) {
    final _ModelBindingScope scope =
        context.inheritFromWidgetOfExactType(_ModelBindingScope);
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, ModifierModel newModel) {
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
  final _ModifierModelBindingState modelBindingState;
  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModifierModelBinding extends StatefulWidget {
  ModifierModelBinding({
    Key key,
    this.initialModel = const ModifierModel(
        name: 'Foo', isAttackModifier: false, percentage: 0),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);
  final ModifierModel initialModel;
  final Widget child;
  _ModifierModelBindingState createState() => _ModifierModelBindingState();
}

class _ModifierModelBindingState extends State<ModifierModelBinding> {
  ModifierModel currentModel;

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  void updateModel(ModifierModel newModel) {
    if (newModel != currentModel) {
      setState(() {
        print(newModel);
        currentModel = newModel;
        newModel.onUpdate(newModel);
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
