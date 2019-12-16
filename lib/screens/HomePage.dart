
import 'package:listadecompras/blocs/BlocProdutoList.dart';
import 'package:listadecompras/screens/AddPage.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras/widgets/ProdutoListTile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  BlocProdutoList bloc;
  
  _buildList(BlocProdutoList listProdutos){
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: listProdutos.getListLength(),
      itemBuilder: (context,index) =>
        ProdutoListTile(produto: listProdutos.getProduto(index), index: index)
      );
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<BlocProdutoList>(context);

    print("Rebuildando o HomePage");

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.assignment),
        title: Consumer<BlocProdutoList>(
          builder: (context,produtos,_){
            return Text("Total: ${produtos.getTotal()}");
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              bloc.clearAll();
            },
          ),
        ],
      ),
      body: Consumer<BlocProdutoList>(
        builder: (context,produtos,_){
          return _buildList(produtos);
        },
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