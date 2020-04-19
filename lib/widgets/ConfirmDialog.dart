import 'package:flutter/material.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:provider/provider.dart';

class ConfirmDialog extends StatelessWidget {

  ProdutosController controller;  

  @override
  Widget build(BuildContext context) {
    this.controller = Provider.of<ProdutosController>(context);
    return AlertDialog(
      title: Text("Deseja realmente apagar a lista?"),
      actions: <Widget>[
        FlatButton(
          child: Text("Sim"),
          onPressed: (){
            controller.clearAll();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Não"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}