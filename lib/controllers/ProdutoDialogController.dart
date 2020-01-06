import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'ProdutoDialogController.g.dart';

class ProdutoDialogController = _ProdutoDialogController
    with _$ProdutoDialogController;

abstract class _ProdutoDialogController with Store {
  @observable
  double total = 0;

  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  int quantidadeCache = 0;
  double precoCache = 0.0;

  @action
  updateTotal(double total) {
    this.total = total;
  }
}
