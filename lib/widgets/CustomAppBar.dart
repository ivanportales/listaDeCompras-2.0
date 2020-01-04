/*import 'package:flutter/material.dart';
import 'package:listadecompras2_5/blocs/BlocProdutoList.dart';

class CustomAppBar extends StatelessWidget {
  bool isSearching = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProdutoList bloc = Provider.of<BlocProdutoList>(context);
    // n vai dar certo com o Provider, pensando em mudar, de novo, pra Bloc com Streams
    return AppBar(
      leading: Icon(Icons.assignment),
      title: Consumer<BlocProdutoList>(
        builder: (context, produtos, _) {
          if (isSearching) {
            return TextField(
              controller: controller,
            );
          } else {
            return Text("Total: ${produtos.getTotal()}");
          }
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            isSearching = true;
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            bloc.clearAll();
          },
        ),
      ],
    );
  }
}
*/
