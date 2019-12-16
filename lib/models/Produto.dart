class Produto{
  int id;
  String nome;
  double preco;
  int quantidade;
  bool comprado;

  Produto({this.id=0,this.nome,this.preco = 0.0,this.quantidade,this.comprado = false});

  toJson(){
    return {
      'id' : this.id,
      'nome': this.nome,
      'preco': this.preco,
      'quantidade': this.quantidade,
      'comprado': this.comprado
    };
  }

  factory Produto.fromJson(Map<dynamic,dynamic>  json){
    return Produto(
      id: json['id'],
      nome: json['nome'],
      preco: json['preco'],
      quantidade: json['quantidade'],
      comprado: json['comprado']
    );
  }

  double getTotal(){
    return this.quantidade * this.preco;
  }
}