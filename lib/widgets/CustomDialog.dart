import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../controllers/ProdutoDialogController.dart';
import '../controllers/ProdutosController.dart';
import '../models/Produto.dart';

class CustomDialog extends StatelessWidget {

  ProdutoDialogController dialogController = ProdutoDialogController();
  Produto produto;
  ProdutosController controller;

  CustomDialog({this.produto, this.controller});

  @override
  Widget build(BuildContext context) {
    print("rebuoldando customdialog");

    dialogController.quantidadeCache  = produto.quantidade;
    dialogController.precoCache = produto.preco;
    
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
              return Text(
                  "${dialogController.total.toStringAsPrecision(4)}",
                  textAlign: TextAlign.center);
            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Cancelar"),
          onPressed: () {
            produto.quantidade = dialogController.quantidadeCache;
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
  }
}