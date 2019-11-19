import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/services/DataBase.dart';

class ProdutoListBloc extends BlocBase{

  List<Produto> produtos = [];
  DataBase db;

  StreamController<List<Produto>> _streamController = StreamController<List<Produto>>();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  ProdutoListBloc(){
    db = DataBase();
    db.getAll().then((value) { 
      print("Iniciando o bloc");
      this.produtos = value;
      input.add(value);
    });
  }

  addProduto(Produto produto){
    produtos.add(produto);
    db.add(produto);
    input.add(produtos);
  }

  removeProduto(Produto produto){
    produtos.remove(produto);
    db.remove(produto.nome);
    input.add(produtos);
  }

  comprarProduto(int index){
    produtos[index].comprado = !produtos[index].comprado;
    db.update(produtos[index]);
    input.add(produtos);
  }

  @override
  void dispose() {
    _streamController.close(); 
    super.dispose();
  }
}