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
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
      child: Container(
        padding: EdgeInsets.only(left: 2,right: 2,bottom: 12),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.97,
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
            hintText: "Ex: Macarrão",
            suffixIcon: Padding(padding: EdgeInsets.only(right: 15),child:Icon(Icons.search)),
            border: InputBorder.none
          ),
        ),
      )
    );
  }

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      pinned: true,
      elevation: 20,
      leading: Icon(Icons.assignment),
      title: Observer(
        builder: (_) {
          print("Rebuildando o Observer do title");
          return Text("Total: ${controller.total.toStringAsPrecision(4)}");
        },
      ),
      bottom: searchBar(context),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
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
      List list = controller.list;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context,index) => ProdutoListTile(produto: list[index], index: index),
          childCount: list.length
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
            builder : (context){
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