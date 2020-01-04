import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/models/Produto.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  ProdutosController controller;
  AddPage({this.controller});

  @override
  _AddPageState createState() => _AddPageState(controller: controller);
}

class _AddPageState extends State<AddPage> {
  TextEditingController produtoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();

  ProdutosController controller;
  _AddPageState({this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.add_shopping_cart),
        title: Text("Add Produto"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.create),
                border: UnderlineInputBorder(),
                hintText: "Nome",
              ),
              controller: produtoController,
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          var nome = produtoController.text;
          var quantidade = int.parse(quantidadeController.text);

          if (nome.isNotEmpty && quantidade > 0) {
            controller.add(Produto(nome: nome, quantidade: quantidade));
          }

          Navigator.pop(context);
        },
      ),
    );
  }
}
