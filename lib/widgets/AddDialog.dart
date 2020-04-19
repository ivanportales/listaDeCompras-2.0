import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/ProdutosController.dart';
import '../models/Produto.dart';

class AddDialog extends StatelessWidget {

  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  ProdutosController controller;

  @override
  Widget build(BuildContext context) {
    this.controller = Provider.of<ProdutosController>(context);
    return AlertDialog(
      title: Text("Add Produto"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.create),
              border: UnderlineInputBorder(),
              hintText: "Nome",
            ),
            controller: nomeController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
          ),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.plus_one),
              border: UnderlineInputBorder(),
              hintText: "Quantidade",
            ),
            controller: quantidadeController,
            keyboardType: TextInputType.number,
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(5),
          child: Text("Add"),
          onPressed: () {
            var nome = nomeController.text;
            var quantidade = int.parse(quantidadeController.text);

            if (nome.isNotEmpty && quantidade > 0) {
              controller.add(Produto(
                  nome: nome, quantidade: quantidade, preco: 0, comprado: false));
            }
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}