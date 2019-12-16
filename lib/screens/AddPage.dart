import 'package:listadecompras/blocs/BlocProdutoList.dart';
import 'package:listadecompras/models/Produto.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  
  TextEditingController produtoController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  BlocProdutoList listBloc;

  _formField(text,controll,icon,type){
    return TextFormField(
      decoration: InputDecoration(
        icon: icon,
        border: UnderlineInputBorder(),
        hintText: text,
      ),
      controller: controll,
      keyboardType: type,
    );
  }

  @override
  Widget build(BuildContext context) {

    listBloc = Provider.of<BlocProdutoList>(context);

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
            _formField("Quantidade",quantidadeController,Icon(Icons.plus_one),TextInputType.number),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          var nome = produtoController.text;
          var quantidade = int.parse(quantidadeController.text);
          listBloc.add(Produto(nome: nome,quantidade: quantidade));
          Navigator.pop(context);
        },
      ),
    );
  }
}