class Produto{
  int id;
  String nome;
  double preco;
  int quantidade;
  bool comprado;

  Produto({this.nome,this.preco,this.quantidade,this.comprado = false});

  toJson(){
    return {
      'nome': this.nome,
      'preco': this.preco,
      'quantidade': this.quantidade,
      'comprado': this.comprado
    };
  }

  factory Produto.fromJson(Map<dynamic,dynamic>  json){
    return Produto(
      nome: json['nome'],
      preco: json['preco'],
      quantidade: json['quantidade'],
      comprado: json['comprado']
    );
  }
}