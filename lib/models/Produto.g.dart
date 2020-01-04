// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Produto.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Produto on _Produto, Store {
  final _$compradoAtom = Atom(name: '_Produto.comprado');

  @override
  bool get comprado {
    _$compradoAtom.context.enforceReadPolicy(_$compradoAtom);
    _$compradoAtom.reportObserved();
    return super.comprado;
  }

  @override
  set comprado(bool value) {
    _$compradoAtom.context.conditionallyRunInAction(() {
      super.comprado = value;
      _$compradoAtom.reportChanged();
    }, _$compradoAtom, name: '${_$compradoAtom.name}_set');
  }
}
