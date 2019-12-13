import 'package:flutter/material.dart';
import 'package:listadecompras/blocs/BlocProdutoList.dart';
import 'package:listadecompras/blocs/BlocTileDialog.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:provider/provider.dart';

class ProdutoListTile extends StatelessWidget {

  Produto produto;
  int index;

  ProdutoListTile({@required this.produto, @required this.index});

  @override
  Widget build(BuildContext context) {

    BlocProdutoList produtos = Provider.of<BlocProdutoList>(context);
    
    return ListTile(
      leading: Checkbox(
      checkColor: Colors.redAccent,
      activeColor: Colors.black,
      value: produto.comprado,
      onChanged: (isChecked){
        produtos.changeStatus(index);
        if(isChecked){
          produtos.incrementTotal(produto.getTotal());
        }
        else{
          produtos.decrementTotal(produto.getTotal());
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
            context: context,
            builder: (_){
              BlocTileDialog dialogBloc = BlocTileDialog(quantidade_cache:produto.quantidade,preco_cache: produto.preco);
              dialogBloc.updateTotal(produto.getTotal());
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
                                produto.quantidade = dialogBloc.quantidade_cache;
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
                                produto.preco = dialogBloc.preco_cache;
                              }else{
                                produto.preco = double.parse(value);
                              }
                              dialogBloc.updateTotal(produto.getTotal());
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text("${dialogBloc.total.toString()}",textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancelar"),
                          onPressed: (){
                            produto.quantidade = dialogBloc.quantidade_cache;
                            produto.preco = dialogBloc.preco_cache;
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("Ok"),
                          onPressed: (){
                            if(!produto.comprado){
                              produto.comprado = true;
                              produtos.update(produto);
                              produtos.incrementTotal(produto.getTotal());
                            }else{
                              produto.quantidade = dialogBloc.quantidade_cache;
                              produto.preco = dialogBloc.preco_cache;
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  }
                );
              },
            ),
            onLongPress: (){
              produtos.remove(produto);
              if(produto.comprado){
                produtos.decrementTotal(produto.getTotal());
              }
            },
        );
  }
}