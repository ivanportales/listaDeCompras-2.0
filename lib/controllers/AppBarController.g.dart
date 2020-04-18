// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppBarController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppBarController on _AppBarController, Store {
  final _$isSearchingAtom = Atom(name: '_AppBarController.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.context.enforceReadPolicy(_$isSearchingAtom);
    _$isSearchingAtom.reportObserved();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.context.conditionallyRunInAction(() {
      super.isSearching = value;
      _$isSearchingAtom.reportChanged();
    }, _$isSearchingAtom, name: '${_$isSearchingAtom.name}_set');
  }

  final _$_AppBarControllerActionController =
      ActionController(name: '_AppBarController');

  @override
  dynamic changeStatus() {
    final _$actionInfo = _$_AppBarControllerActionController.startAction();
    try {
      return super.changeStatus();
    } finally {
      _$_AppBarControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isSearching: ${isSearching.toString()}';
    return '{$string}';
  }
}
