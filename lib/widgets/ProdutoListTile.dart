import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/models/Produto.dart';

import 'package:listadecompras2_5/widgets/TileDialog.dart';
import 'package:provider/provider.dart';

class ProdutoListTile extends StatelessWidget {
  Produto produto;
  int index;
  ProdutosController controller;

  ProdutoListTile(
      {@required this.produto,
      @required this.index});

  @override
  Widget build(BuildContext context) {
    this.controller = Provider.of<ProdutosController>(context);
    return Observer(builder: (_) {
      return Card(
        color: Colors.transparent,
        margin: EdgeInsets.only(right: 12, left: 12, top: 8),
        child: Dismissible(
          key: Key(produto.id.toString()),
          
          onDismissed: (_) {
            controller.remove(produto);
            if (produto.comprado) {
              controller.decrementTotal(produto.getTotal());
            }
          },
          background: Container(
            color: Colors.white12,
            child: Center(
              child: Icon(Icons.delete_outline),
            ),

          ),
          child: ListTile(
            leading: Checkbox(
              checkColor: Colors.redAccent,
              activeColor: Colors.black,
              value: produto.comprado,
              onChanged: (isChecked) {
                produto.comprado = isChecked;
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
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (_) {
                  print("Rebuildando Dialog");
                  return TileDialog(produto: produto);
                });
            }, 
          ),
        ),
      );
    });
  }
}
