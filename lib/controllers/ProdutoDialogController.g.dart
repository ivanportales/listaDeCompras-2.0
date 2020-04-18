// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProdutoDialogController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoDialogController on _ProdutoDialogController, Store {
  final _$totalAtom = Atom(name: '_ProdutoDialogController.total');

  @override
  double get total {
    _$totalAtom.context.enforceReadPolicy(_$totalAtom);
    _$totalAtom.reportObserved();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.context.conditionallyRunInAction(() {
      super.total = value;
      _$totalAtom.reportChanged();
    }, _$totalAtom, name: '${_$totalAtom.name}_set');
  }

  final _$_ProdutoDialogControllerActionController =
      ActionController(name: '_ProdutoDialogController');

  @override
  dynamic updateTotal(double total) {
    final _$actionInfo =
        _$_ProdutoDialogControllerActionController.startAction();
    try {
      return super.updateTotal(total);
    } finally {
      _$_ProdutoDialogControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'total: ${total.toString()}';
    return '{$string}';
  }
}
