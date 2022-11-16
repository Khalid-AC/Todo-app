import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/pages/todos_page.dart';
import 'package:todo_app/providers/providers.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider<TodoFilter, TodoFilterState>(
            create: (context) => TodoFilter()),
        StateNotifierProvider<TodoSearch, TodoSearchState>(
            create: (context) => TodoSearch()),
        StateNotifierProvider<TodoList, TodoListState>(
            create: (context) => TodoList()),
        StateNotifierProvider<ActiveTodoCount, ActiveTodoCountState>(
            create: (context) => ActiveTodoCount()),
        StateNotifierProvider<FilteredTodos, FilterdTodosState>(
            create: (context) => FilteredTodos()),
      ],

      //
      child: MaterialApp(
        title: "Todo app",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
