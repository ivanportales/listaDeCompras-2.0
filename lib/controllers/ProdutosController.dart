import 'package:listadecompras2_5/models/Produto.dart';
import 'package:listadecompras2_5/services/DataBase.dart';
import 'package:mobx/mobx.dart';

part "ProdutosController.g.dart";

class ProdutosController = _ProdutosController with _$ProdutosController;

abstract class _ProdutosController with Store {
  @observable
  ObservableList<Produto> produtos = ObservableList<Produto>();

  @observable
  double total = 0.0;

  @observable
  String  nQuery = "";

  DataBase dataBase;

  _ProdutosController() {
    _init();
  }

  _init() async {
    dataBase = DataBase();
    var tempList = await dataBase.getAll();
    total = _initTotal(tempList);
    produtos.addAll(tempList);
  }

  _initTotal(List<Produto> tempList) {
    double aux = 0;
    tempList.forEach((p) {
      if (p.comprado) {
        aux += p.getTotal();
      }
    });
    return aux;
  }

  @computed
  get list {
    return (nQuery.isEmpty) ? produtos : produtos.where((item) => item.nome.toLowerCase().contains(nQuery.toLowerCase())).toList();
  }

  @action
  add(Produto produto) async {
    await dataBase.add(produto);
    produtos.add(produto);
  }

  @action
  remove(Produto produto) async {
    await dataBase.remove(produto);
    produtos.remove(produto);
  }

  update(Produto produto) async {
    /*int index = produtos.indexOf(produto);
    produtos[index] = produto;*/
    await dataBase.update(produto);
  }

  @action
  clearAll() async {
    await dataBase.clearAll();
    total = 0.0;
    produtos.clear();
  }

  @action
  incrementTotal(double val) {
    total += val;
  }

  @action
  decrementTotal(double val) {
    total -= val;
  }
}

// flutter pub run build_runner build
// flutter pub run build_runner clean
// flutter packages pub run build_runner build --delete-conflicting-outputs