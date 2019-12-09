import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:listadecompras/blocs/ProdutoListBloc.dart';
import 'package:listadecompras/screens/HomePage.dart';
import 'package:flutter/material.dart';

import 'blocs/TotalBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => TotalBloc()),
        Bloc((i) => ProdutoListBloc()),
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
