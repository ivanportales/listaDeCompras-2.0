import 'dart:async';

import 'package:listadecompras/models/Produto.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DataBase {

  Completer<Box> completer = Completer<Box>();

  DataBase(){
    _initDb();
  }

  void _initDb() async {
    final directory = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    final box = Hive.openBox('produtos');
    completer.complete(box);
  }

  Future<List<Produto>> getAll() async {
    final box = await completer.future;
    return box.values.map((item) => Produto.fromJson(item)).toList();
  }

  add(Produto produto) async {
    final box = await completer.future;
    produto.id = produto.hashCode;
    await box.put(produto.id,produto.toJson());
    return produto;
  }

  update(Produto produto) async {
    final box = await completer.future;
    await box.put(produto.id, produto.toJson());
  }

  remove(Produto produto) async {
    final box = await completer.future;
    await box.delete(produto.id);
  }

  clearAll() async {
    final box = await completer.future;
    await box.clear();
  }
}