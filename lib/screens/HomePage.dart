import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/blocs/ProdutoListBloc.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/screens/AddPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{

  ProdutoListBloc bloc;

   _buildTile(Produto produto,int index){
    return ListTile(
      leading: Checkbox(
        value: produto.comprado,
        onChanged: (_){
          bloc.comprarProduto(index);
        },
      ),
      title: Text(
        "${produto.nome}",
        style: (produto.comprado) ?  TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough,fontStyle: FontStyle.italic) : TextStyle()
      ),
      onLongPress: (){
        bloc.removeProduto(produto);
      },
    );
  }

  _buildList(produtoList){
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: produtoList.length,
      itemBuilder: (context,index) =>
        _buildTile(produtoList[index],index)
    );
  }

  @override
  Widget build(BuildContext context) {

    bloc = BlocProvider.getBloc<ProdutoListBloc>();

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.assignment),
        title: Text("Lista de Compras"),
      ),
      body: StreamBuilder(
        initialData: bloc.produtos,
        stream: bloc.output,
        builder: (context, snapshot){
          print("iniciando o builder da stream");
          List<Produto> produtoList = snapshot.data;
          return _buildList(produtoList);
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()));
        },    
      ),
    );
  }
}