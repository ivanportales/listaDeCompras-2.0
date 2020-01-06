import 'package:mobx/mobx.dart';

part 'Produto.g.dart';

class Produto extends _Produto with _$Produto {
  Produto({int id, String nome, double preco, int quantidade, bool comprado})
      : super(
            id: id,
            nome: nome,
            preco: preco,
            quantidade: quantidade,
            comprado: comprado);

  toJson() {
    return {
      'id': this.id,
      'nome': this.nome,
      'preco': this.preco,
      'quantidade': this.quantidade,
      'comprado': this.comprado
    };
  }

  factory Produto.fromJson(Map<dynamic, dynamic> json) {
    return Produto(
        id: json['id'],
        nome: json['nome'],
        preco: json['preco'],
        quantidade: json['quantidade'],
        comprado: json['comprado']);
  }

  double getTotal() {
    return this.quantidade * this.preco;
  }
}

abstract class _Produto with Store {
  int id;
  String nome;
  double preco;
  int quantidade;

  @observable
  bool comprado;

  _Produto(
      {this.id = 0,
      this.nome,
      this.preco = 0.0,
      this.quantidade,
      this.comprado});
}
