import 'package:flutter/material.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/services/DataBase.dart';

class BlocProdutoList extends ChangeNotifier{

  List<Produto> _produtos = [];
  double _total = 0.0;
  DataBase _database;

  BlocProdutoList(){
    _database = DataBase();
    _database.getAll().then((value){
      _produtos = value;
      value.forEach((item){
        if(item.comprado){
          _total += item.quantidade * item.preco;
        }
      });
      notifyListeners();
    });
  }

  add(Produto produto){
    _produtos.add(produto);
    _database.add(produto);
    notifyListeners();
  }

  remove(Produto produto){
    _produtos.remove(produto);
    _database.remove(produto);
    notifyListeners();
  }

  update(Produto produto,{int index = 0}){
    int index = _produtos.indexOf(produto);
    _produtos[index] = produto;
    _database.update(produto);
    notifyListeners();
  }

  changeStatus(int index){
    _produtos[index].comprado = !_produtos[index].comprado;
    _database.update(_produtos[index]);
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
    return _produtos.length;
  }

  getProduto(int index){
    return _produtos[index];
  }

  clearAll(){
    _produtos.clear();
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