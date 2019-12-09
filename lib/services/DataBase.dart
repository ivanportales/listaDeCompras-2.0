import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DataBase extends Disposable{

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
    produto.id = box.values.length;
    await box.put(produto.nome, produto.toJson());
    return produto;
  }

  update(Produto produto) async {
    final box = await completer.future;
    await box.put(produto.nome, produto.toJson());
  }

  remove(Produto produto) async {
    final box = await completer.future;
    String chave = produto.nome;
    await box.delete(chave);
  }

  clearAll() async {
    final box = await completer.future;
    await box.clear();
  }

  @override
  void dispose() async{
    var box = await completer.future;
    box.close();
  }
}