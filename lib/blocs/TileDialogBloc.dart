import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/models/Produto.dart';

class TileDialogBloc extends BlocBase{

  TextEditingController nomeController = TextEditingController();
  TextEditingController precoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  double total = 0.0;

  StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream; 

  updateTotal(double total){
    input.add(total);
  }
}