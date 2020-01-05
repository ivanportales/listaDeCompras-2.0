import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/models/Produto.dart';

class ProdutoListTile extends StatelessWidget {
  Produto produto;
  int index;
  ProdutosController controller;

  ProdutoListTile(
      {@required this.produto,
      @required this.index,
      @required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Card(
        color: Colors.transparent,
        child: ListTile(
          leading: Checkbox(
            checkColor: Colors.redAccent,
            activeColor: Colors.black,
            value: produto.comprado,
            onChanged: (isChecked) {
              produto.comprado = isChecked;
              print(isChecked);
              controller.update(produto);
              if (isChecked) {
                controller.incrementTotal(produto.getTotal());
              } else {
                controller.decrementTotal(produto.getTotal());
              }
            },
          ),
          title: Text("${produto.nome}",
              style: (produto.comprado)
                  ? TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontStyle: FontStyle.italic)
                  : TextStyle()),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              /*
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    BlocTileDialog dialogBloc = BlocTileDialog(
                        quantidadeCache: produto.quantidade,
                        precoCache: produto.preco);
                    dialogBloc.updateTotal(produto.getTotal());
                    return AlertDialog(
                      title: Text("Produto: ${produto.nome}"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.plus_one),
                              border: UnderlineInputBorder(),
                              hintText: "${produto.quantidade}",
                            ),
                            keyboardType: TextInputType.number,
                            controller: dialogBloc.quantidadeController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                produto.quantidade = dialogBloc.quantidadeCache;
                              } else {
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
                            onChanged: (value) {
                              if (value.isEmpty) {
                                produto.preco = dialogBloc.precoCache;
                              } else {
                                produto.preco = double.parse(value);
                              }
                              dialogBloc.updateTotal(produto.getTotal());
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text("${dialogBloc.total.toString()}",
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            produto.quantidade = dialogBloc.quantidadeCache;
                            produto.preco = dialogBloc.precoCache;
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            if (!produto.comprado) {
                              produto.comprado = true;
                              produtos.update(produto);
                              produtos.incrementTotal(produto.getTotal());
                            } else {
                              produto.quantidade = dialogBloc.quantidadeCache;
                              produto.preco = dialogBloc.precoCache;
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            */
            },
          ),
          onLongPress: () {
            controller.remove(produto);
            if (produto.comprado) {
              controller.decrementTotal(produto.getTotal());
            }
          },
        ),
      );
    });
  }
}
