import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/models/Produto.dart';

class TotalBloc extends BlocBase{

  double total = 0;

  StreamController _streamController = StreamController();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream; 

  incrementTotal(Produto produto){
    total += (produto.quantidade * produto.preco); 
    input.add(total);
  }

  decrementTotal(Produto produto){
    total -= (produto.quantidade * produto.preco); 
    input.add(total);
  }

  setTotal(double t){
    total = t;
    input.add(total);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}