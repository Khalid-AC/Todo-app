import 'package:flutter/material.dart';
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
        ChangeNotifierProvider<TodoFilter>(create: (context) => TodoFilter()),
        ChangeNotifierProvider<TodoSearch>(create: (context) => TodoSearch()),
        ChangeNotifierProvider<TodoList>(create: (context) => TodoList()),

        //
        ChangeNotifierProxyProvider<TodoList, ActiveTodoCount>(
          create: (context) => ActiveTodoCount(),
          update:
              ((context, TodoList todoList, ActiveTodoCount? activeTodoCount) =>
            activeTodoCount!..update(todoList)
            
          ),
        ),

        //
        ChangeNotifierProxyProvider3<TodoFilter, TodoSearch, TodoList,
                FilterdTodos>(
            create: (_) => FilterdTodos(),
            update: (_, TodoFilter todoFilter, TodoSearch todoSearch,
                    TodoList todoList, FilterdTodos? filterdTodo) =>
                filterdTodo!..update(todoFilter, todoSearch, todoList)),

        
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
