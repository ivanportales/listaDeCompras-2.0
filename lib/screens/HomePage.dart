import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/screens/AddPage.dart';
import 'package:flutter/material.dart';
import 'package:listadecompras2_5/widgets/CustomAppBar.dart';
import 'package:listadecompras2_5/widgets/ProdutoListTile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProdutosController controller = ProdutosController();

  @override
  Widget build(BuildContext context) {
    print("Rebuildando o HomePage");
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.assignment),
        title: Observer(
          builder: (_) {
            print("Rebuildando o Observer do total");
            return Text("Total: ${controller.total.toStringAsPrecision(2)}");
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              controller.clearAll();
            },
          ),
        ],
      ),
      body: Observer(
        builder: (context) {
          print("Rebuildando o Observer da Lista");
          return ListView.builder(
              padding: EdgeInsets.all(5),
              itemCount: controller.produtos.length,
              itemBuilder: (context, index) => ProdutoListTile(
                    produto: controller.produtos[index],
                    index: index,
                    controller: controller,
                  ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPage(
                        controller: controller,
                      )));
        },
      ),
    );
  }
}
