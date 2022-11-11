import 'package:flutter/material.dart';
import 'package:todo_app/pages/todos_page.dart';
void main(List<String> args) {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: "Todo app",
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const TodosPage(),
    );
  }
}