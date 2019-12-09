import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/blocs/TotalBloc.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/services/DataBase.dart';

class ProdutoListBloc extends BlocBase{

  List<Produto> produtos = [];
  TotalBloc totalBloc = BlocProvider.getBloc<TotalBloc>();
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

      double t = 0.0;
      value.forEach((p){
        if(p.comprado){
          t += p.quantidade * p.preco;
        }
      });

      totalBloc.setTotal(t);
    });
  }

  addProduto(Produto produto){
    produtos.add(produto);
    db.add(produto);
    input.add(produtos);
  }

  removeProduto(Produto produto){
    produtos.remove(produto);
    db.remove(produto);
    input.add(produtos);
  }

  updateProduto(Produto produto){
    db.update(produto);
    int index = produtos.indexOf(produto);
    produtos[index] = produto; 
    input.add(produtos);
  }

  comprarProduto(int index){
    produtos[index].comprado = !produtos[index].comprado;
    db.update(produtos[index]);
    input.add(produtos);
  }

  apagarProdutos(){
    db.clearAll();
    produtos.clear();
    input.add(produtos);
  }

  @override
  void dispose() {
    _streamController.close(); 
    super.dispose();
  }
}