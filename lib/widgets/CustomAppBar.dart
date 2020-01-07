import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/AppBarController.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';

class CustomAppBar extends StatelessWidget {
  ProdutosController produtosController;
  TextEditingController textController = TextEditingController();

  CustomAppBar({this.produtosController});

  @override
  Widget build(BuildContext context) {
    AppBarController appBarController = AppBarController();

    return Observer(builder: (_) {
      if (!appBarController.isSearching) {
        return AppBar(
          leading: Icon(Icons.assignment),
          title: Observer(
            builder: (_) {
              print("Rebuildando o Observer do total");
              return Text("Total: ${produtosController.total}");
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                appBarController.changeStatus();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                produtosController.clearAll();
              },
            ),
          ],
        );
      } else {
        return AppBar(
          leading: Icon(Icons.assignment),
          title: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                appBarController.changeStatus();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                produtosController.clearAll();
              },
            ),
          ],
        );
      }
    });
  }
}
