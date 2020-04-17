import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/models/Produto.dart';
import 'package:listadecompras2_5/widgets/CustomDialog.dart';

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
                return CustomDialog(produto: produto,controller: controller);
              });
          },
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
