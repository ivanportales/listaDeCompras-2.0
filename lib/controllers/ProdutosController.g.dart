// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProdutosController.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutosController on _ProdutosController, Store {
  Computed<dynamic> _$listComputed;

  @override
  dynamic get list =>
      (_$listComputed ??= Computed<dynamic>(() => super.list)).value;

  final _$produtosAtom = Atom(name: '_ProdutosController.produtos');

  @override
  ObservableList<Produto> get produtos {
    _$produtosAtom.context.enforceReadPolicy(_$produtosAtom);
    _$produtosAtom.reportObserved();
    return super.produtos;
  }

  @override
  set produtos(ObservableList<Produto> value) {
    _$produtosAtom.context.conditionallyRunInAction(() {
      super.produtos = value;
      _$produtosAtom.reportChanged();
    }, _$produtosAtom, name: '${_$produtosAtom.name}_set');
  }

  final _$totalAtom = Atom(name: '_ProdutosController.total');

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

  final _$nQueryAtom = Atom(name: '_ProdutosController.nQuery');

  @override
  String get nQuery {
    _$nQueryAtom.context.enforceReadPolicy(_$nQueryAtom);
    _$nQueryAtom.reportObserved();
    return super.nQuery;
  }

  @override
  set nQuery(String value) {
    _$nQueryAtom.context.conditionallyRunInAction(() {
      super.nQuery = value;
      _$nQueryAtom.reportChanged();
    }, _$nQueryAtom, name: '${_$nQueryAtom.name}_set');
  }

  final _$addAsyncAction = AsyncAction('add');

  @override
  Future add(Produto produto) {
    return _$addAsyncAction.run(() => super.add(produto));
  }

  final _$removeAsyncAction = AsyncAction('remove');

  @override
  Future remove(Produto produto) {
    return _$removeAsyncAction.run(() => super.remove(produto));
  }

  final _$clearAllAsyncAction = AsyncAction('clearAll');

  @override
  Future clearAll() {
    return _$clearAllAsyncAction.run(() => super.clearAll());
  }

  final _$_ProdutosControllerActionController =
      ActionController(name: '_ProdutosController');

  @override
  dynamic incrementTotal(double val) {
    final _$actionInfo = _$_ProdutosControllerActionController.startAction();
    try {
      return super.incrementTotal(val);
    } finally {
      _$_ProdutosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic decrementTotal(double val) {
    final _$actionInfo = _$_ProdutosControllerActionController.startAction();
    try {
      return super.decrementTotal(val);
    } finally {
      _$_ProdutosControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'produtos: ${produtos.toString()},total: ${total.toString()},nQuery: ${nQuery.toString()},list: ${list.toString()}';
    return '{$string}';
  }
}
