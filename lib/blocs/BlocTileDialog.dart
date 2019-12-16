import 'package:flutter/material.dart';

class BlocTileDialog extends ChangeNotifier{

  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  double total = 0.0;
  int quantidadeCache = 0;
  double precoCache = 0.0;

  BlocTileDialog({this.quantidadeCache, this.precoCache});

  updateTotal(double total){
    this.total = total;
    notifyListeners();
  }
}