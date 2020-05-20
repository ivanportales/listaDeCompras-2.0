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

  Widget searchBar(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 120, left: 13,right: 13),
      child: TextField(
        cursorColor: Theme.of(context).cursorColor,
        textCapitalization: TextCapitalization.words,
        controller: TextEditingController(),
        onChanged: (value) {
          controller.nQuery = value;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white10,
          prefixIcon: Icon(
            Icons.search,
            size: 16,
          ),
          border: InputBorder.none
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,
      elevation: 20,
      expandedHeight: MediaQuery.of(context).size.height * 0.13,
      leading: Icon(Icons.assignment),
      title: Observer(
        builder: (_) {
          print("Rebuildando o Observer do title");
          return Text("Total: ${controller.total.toStringAsPrecision(4)}");
        },
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: searchBar(context),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            showDialog(
              context: context,
              child: ConfirmDialog()
            );
          },
        ),
      ]);  
    }

    Widget listView() {
      print("Rebuildando o Observer da Lista");
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context,index) => ProdutoListTile(produto: controller.list[index], index: index),
          childCount: controller.list.length
        ),
      );
    }

  @override
  Widget build(BuildContext context) {
    print("Rebuildando o HomePage");
    this.controller = Provider.of<ProdutosController>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar(context),
          Observer(
            builder : (context) {
              return listView();
            }
          )
        ],
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