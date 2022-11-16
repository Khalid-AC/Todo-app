// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_app/models/todo_model.dart';

class TodoListState extends Equatable {
  final List<Todo> todos;
  const TodoListState({
    required this.todos,
  });

  factory TodoListState.initial() {
    return TodoListState(todos: [
      Todo(id: "1", description: "Clean the room"),
      Todo(id: "2", description: "Wash the dish"),
      Todo(id: "3", description: "Do Homework"),
    ]);
  }

  @override
  List<Object> get props => [todos];

  TodoListState copyWith({
    List<Todo>? todos,
  }) {
    return TodoListState(
      todos: todos ?? this.todos,
    );
  }

  @override
  bool get stringify => true;
}

/*class TodoList with ChangeNotifier {
  TodoListState _state = TodoListState.initial();
  TodoListState get state => _state;

  void addTodo(String description) {
    final newTodo = Todo(description: description);
    final newTodos = [..._state.todos, newTodo];

    _state = _state.copyWith(todos: newTodos);
   

    notifyListeners();
  }

  void editTodo(String id, String newDescription) {
    final newTodos = _state.todos.map((Todo todo) {
      if (id == todo.id) {
        return Todo(
            id: todo.id,
            description: newDescription,
            isCompleted: todo.isCompleted);
      } else {
        return todo;
      }
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          description: todo.description,
          isCompleted: !todo.isCompleted,
        );
      } else {
        return todo;
      }
    }).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(String id) {
    final newTodos = _state.todos.where((todo) => todo.id != id).toList();

    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }
}*/

class TodoList extends StateNotifier<TodoListState> {
  TodoList() : super(TodoListState.initial());

  void addTodo(String description) {
    final newTodo = Todo(description: description);
    final newTodos = [...state.todos, newTodo];

    state = state.copyWith(todos: newTodos);
  }

  void editTodo(String id, String newDescription) {
    final newTodos = state.todos.map((Todo todo) {
      if (id == todo.id) {
        return Todo(
            id: todo.id,
            description: newDescription,
            isCompleted: todo.isCompleted);
      } else {
        return todo;
      }
    }).toList();

    state = state.copyWith(todos: newTodos);
  }

  void toggleTodo(String id) {
    final newTodos = state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
          id: todo.id,
          description: todo.description,
          isCompleted: !todo.isCompleted,
        );
      } else {
        return todo;
      }
    }).toList();

    state = state.copyWith(todos: newTodos);
  }

  void removeTodo(String id) {
    final newTodos = state.todos.where((todo) => todo.id != id).toList();

    state = state.copyWith(todos: newTodos);
  }
}
