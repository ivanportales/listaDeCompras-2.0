import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/AppBarController.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras2_5/widgets/AddDialog.dart';
import 'package:listadecompras2_5/widgets/ConfirmDialog.dart';
import 'package:listadecompras2_5/widgets/ProdutoListTile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProdutosController controller;
  AppBarController appBarController = AppBarController();

  @override
  Widget build(BuildContext context) {
    print("Rebuildando o HomePage");
    this.controller = Provider.of<ProdutosController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.assignment),
        title: Observer(
          builder: (_) {
            print("Rebuildando o Observer do title");
            return appBarController.isSearching
                ? TextField(
                    controller: TextEditingController(),
                    onChanged: (value) {
                      controller.nQuery = value;
                    },
                  )
                : Text("Total: ${controller.total.toStringAsPrecision(4)}");
          },
        ),
        actions: <Widget>[
          Observer(builder: (_) {
            return appBarController.isSearching
                ? IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      controller.nQuery = "";
                      appBarController.isSearching =
                          !appBarController.isSearching;
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      appBarController.isSearching =
                          !appBarController.isSearching;
                    },
                  );
          }),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                child: ConfirmDialog()
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          print("Rebuildando o Observer da Lista");
          var list = controller.list;
          return ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: list.length,
              itemBuilder: (context, index) => ProdutoListTile(
                    produto: list[index],
                    index: index,
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AddDialog();
            }
          );
        },
      ),
    );
  }
}
