import 'package:listadecompras2_5/controllers/ProdutosController.dart';
import 'package:listadecompras2_5/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProdutosController> (create: (_) => ProdutosController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme:
            ThemeData(brightness: Brightness.dark, accentColor: Colors.redAccent),
        home: HomePage(),
      ),
    );
  }
}
