// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/todo_filter.dart';
import 'package:todo_app/providers/todo_list.dart';
import 'package:todo_app/providers/todo_search.dart';

class FilterdTodosState extends Equatable {
  final List<Todo> filterdTodos;
  const FilterdTodosState({
    required this.filterdTodos,
  });

  factory FilterdTodosState.initial() {
    return const FilterdTodosState(filterdTodos: []);
  }

  @override
  List<Object> get props => [filterdTodos];

  FilterdTodosState copyWith({
    List<Todo>? filterdTodos,
  }) {
    return FilterdTodosState(
      filterdTodos: filterdTodos ?? this.filterdTodos,
    );
  }

  @override
  bool get stringify => true;
}

class FilterdTodos with ChangeNotifier {
  FilterdTodosState _state = FilterdTodosState.initial();
  FilterdTodosState get state => _state;

  void update(
    TodoFilter todoFilter,
    TodoSearch todoSearch,
    TodoList todoList,
  ) {
    List<Todo> filteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.completed:
        filteredTodos =
            todoList.state.todos.where((todo) => todo.isCompleted).toList();
        break;
      case Filter.active:
        filteredTodos =
            todoList.state.todos.where((todo) => !todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      filteredTodos = todoList.state.todos
          .where((todo) => todo.description
              .toLowerCase()
              .contains(todoSearch.state.searchTerm))
          .toList();
    }

    _state = _state.copyWith(filterdTodos: filteredTodos);
    notifyListeners();  
  }
}
