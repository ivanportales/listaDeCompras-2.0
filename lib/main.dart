import 'package:listadecompras/blocs/BlocProdutoList.dart';
import 'package:listadecompras/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider(create: (_) => BlocProdutoList()),
      ],
      child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: Brightness.dark,
              accentColor: Colors.redAccent
            ),
            home: HomePage(),
        ), 
    );
  }
}
