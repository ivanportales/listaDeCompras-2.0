import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/ProdutoDialogController.dart';
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
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) {
                    print("Rebuildando Dialog");
                    ProdutoDialogController dialogController =
                        ProdutoDialogController();
                    dialogController.quantidadeCache = produto.quantidade;
                    dialogController.precoCache = produto.preco;
                    dialogController.updateTotal(produto.getTotal());
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
                            controller: dialogController.quantidadeController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                produto.quantidade =
                                    dialogController.quantidadeCache;
                              } else {
                                produto.quantidade = int.parse(value);
                              }
                              dialogController.updateTotal(produto.getTotal());
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.monetization_on),
                              border: UnderlineInputBorder(),
                              hintText: "${produto.preco}",
                            ),
                            keyboardType: TextInputType.number,
                            controller: dialogController.precoController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                produto.preco = dialogController.precoCache;
                              } else {
                                produto.preco = double.parse(value);
                              }
                              dialogController.updateTotal(produto.getTotal());
                            },
                          ),
                          Observer(
                            builder: (_) {
                              print("Observer do total dialog");
                              return Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text("${dialogController.total}",
                                    textAlign: TextAlign.center),
                              );
                            },
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Cancelar"),
                          onPressed: () {
                            produto.quantidade =
                                dialogController.quantidadeCache;
                            produto.preco = dialogController.precoCache;
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text("Ok"),
                          onPressed: () {
                            if (!produto.comprado) {
                              produto.comprado = true;
                              controller.update(produto);
                              controller.incrementTotal(produto.getTotal());
                            } else {
                              produto.quantidade =
                                  dialogController.quantidadeCache;
                              produto.preco = dialogController.precoCache;
                            }
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
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
