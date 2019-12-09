import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/blocs/ProdutoListBloc.dart';
import 'package:listadecompras/blocs/TileDialogBloc.dart';
import 'package:listadecompras/blocs/TotalBloc.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:listadecompras/screens/AddPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProdutoListBloc bloc;
  TotalBloc total_bloc;
  BuildContext this_context;

   _buildTile(Produto produto,int index){
    return ListTile(
      leading: Checkbox(
        checkColor: Colors.redAccent,
        activeColor: Colors.black,
        value: produto.comprado,
        onChanged: (isChecked){
          bloc.comprarProduto(index);
          if(isChecked){
            total_bloc.incrementTotal(produto);
          }
          else{
            total_bloc.decrementTotal(produto);
          }
        },
      ),
      title: Text(
        "${produto.nome}",
        style: (produto.comprado) ?  TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough,fontStyle: FontStyle.italic) : TextStyle()
      ),
      trailing: IconButton(
        icon: Icon(Icons.edit),
        onPressed: (){
          showDialog(
            barrierDismissible: false,
            context: this_context,
            builder: (_){
              TileDialogBloc dialogBloc = TileDialogBloc();
              dialogBloc.updateTotal(produto.getTotal());
              var quantidade_cache = produto.quantidade;
              var preco_cache = produto.preco;
              return AlertDialog(
                title: Text("Produto: ${produto.nome}"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:<Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.plus_one),
                        border: UnderlineInputBorder(),
                        hintText: "${produto.quantidade}",
                      ),
                      keyboardType: TextInputType.number,
                      controller: dialogBloc.quantidadeController,
                      onChanged: (value){
                        if(value.isEmpty){
                          produto.quantidade = quantidade_cache;
                        }else{
                           produto.quantidade = int.parse(value);
                        }
                        dialogBloc.updateTotal(produto.getTotal());
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.monetization_on),
                        border: UnderlineInputBorder(),
                        hintText: "${produto.preco}",
                      ),
                      keyboardType: TextInputType.number,
                      controller: dialogBloc.precoController,
                      onChanged: (value){
                        if(value.isEmpty){
                          produto.preco = preco_cache;
                        }else{
                          produto.preco = double.parse(value);
                        }
                        dialogBloc.updateTotal(produto.getTotal());
                      },
                    ),
                    StreamBuilder(
                      stream: dialogBloc.output,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text("${snapshot.data.toString()}",textAlign: TextAlign.center),
                        );
                      }
                    )
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Cancelar"),
                    onPressed: (){
                      produto.quantidade = quantidade_cache;
                      produto.preco = preco_cache;
                      Navigator.pop(this_context);
                    },
                  ),
                  FlatButton(
                    child: Text("Ok"),
                    onPressed: (){
                      if(!produto.comprado){
                        produto.comprado = true;
                        bloc.updateProduto(produto);
                        total_bloc.incrementTotal(produto);
                      }else{
                        produto.quantidade = quantidade_cache;
                        produto.preco = preco_cache;
                      }
                      Navigator.pop(this_context);
                    },
                  ),
                ],
              );
            }
          );
        },
      ),
      onLongPress: (){
        bloc.removeProduto(produto);
        if(produto.comprado){
          total_bloc.decrementTotal(produto);
        }
      },
    );
  }

  _buildList(produtoList){
    return ListView.builder(
      padding: EdgeInsets.all(5),
      itemCount: produtoList.length,
      itemBuilder: (context,index) =>
        _buildTile(produtoList[index],index)
    );
  }

  @override
  void initState() {
    super.initState();
    this_context = context;
    bloc = BlocProvider.getBloc<ProdutoListBloc>();
    total_bloc = BlocProvider.getBloc<TotalBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.assignment),
        title: StreamBuilder(
          initialData: total_bloc.total,
          stream: total_bloc.output,
          builder: (context, snapshot) {
            return Text("Total = ${snapshot.data.toString()}");
          }
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              bloc.apagarProdutos();
              bloc.totalBloc.setTotal(0.0);
            },
          ),
        ],
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