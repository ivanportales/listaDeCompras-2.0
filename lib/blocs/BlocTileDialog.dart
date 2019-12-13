import 'package:flutter/material.dart';

class BlocTileDialog extends ChangeNotifier{

  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  double total = 0.0;
  int quantidade_cache = 0;
  double preco_cache = 0.0;

  BlocTileDialog({this.quantidade_cache, this.preco_cache});

  updateTotal(double total){
    this.total = total;
    notifyListeners();
  }
}