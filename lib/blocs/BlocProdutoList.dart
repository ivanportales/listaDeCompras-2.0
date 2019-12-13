import 'package:flutter/material.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/services/DataBase.dart';

class BlocProdutoList extends ChangeNotifier{

  List<Produto> produtos = [];
  double _total = 0.0;
  DataBase _database;

  BlocProdutoList(){
    _database = DataBase();
    _database.getAll().then((value){
      produtos = value;
      value.forEach((item){
        if(item.comprado){
          _total += item.quantidade * item.preco;
        }
      });
      notifyListeners();
    });
  }

  add(Produto produto){
    produtos.add(produto);
    _database.add(produto);
    notifyListeners();
  }

  remove(Produto produto){
    produtos.remove(produto);
    _database.remove(produto);
    notifyListeners();
  }

  update(Produto produto,{int index = 0}){
    int index = produtos.indexOf(produto);
    produtos[index] = produto;
    _database.update(produto);
    notifyListeners();
  }

  changeStatus(int index){
    produtos[index].comprado = !produtos[index].comprado;
  }

  incrementTotal(double valor){
    _total += valor;
    notifyListeners();
  }

  decrementTotal(double valor){
    _total -= valor;
    notifyListeners();
  }

  getTotal(){
    return _total;
  }

  getListLength(){
    return produtos.length;
  }

  clearAll(){
    produtos.clear();
    _database.clearAll();
    _eraseTotal();
  }

  _eraseTotal(){
    _total = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}