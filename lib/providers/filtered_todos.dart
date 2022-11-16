// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/providers/providers.dart';

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

// Using ChangNotifierProxyProvider
/*class FilterdTodos with ChangeNotifier {
  //FilterdTodosState _state = FilterdTodosState.initial();
  late FilterdTodosState _state;
  FilterdTodosState get state => _state;

  final List<Todo> initialFilteredTodos;
  FilterdTodos({
    required this.initialFilteredTodos,
  }) {
    _state = FilterdTodosState(filterdTodos: initialFilteredTodos);
  }

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
}*/

/*class FilteredTodos {
  TodoFilter todoFilter;
  TodoSearch todoSearch;
  TodoList todoList;

  //
  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  FilterdTodosState get state {
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

    return FilterdTodosState(filterdTodos: filteredTodos);
  }
}*/

class FilteredTodos extends StateNotifier<FilterdTodosState> with LocatorMixin {
  FilteredTodos() : super(FilterdTodosState.initial());

  @override
  void update(Locator watch) {
    final filter = watch<TodoFilterState>().filter;
    final searchTerm = watch<TodoSearchState>().searchTerm;
    final todos = watch<TodoListState>().todos;

    List<Todo> filteredTodos;

    switch (filter) {
      case Filter.completed:
        filteredTodos = todos.where((todo) => todo.isCompleted).toList();
        break;
      case Filter.active:
        filteredTodos = todos.where((todo) => !todo.isCompleted).toList();
        break;
      case Filter.all:
      default:
        filteredTodos = todos;
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = todos
          .where((todo) => todo.description.toLowerCase().contains(searchTerm))
          .toList();
    }

    state = state.copyWith(filterdTodos: filteredTodos,);
    super.update(watch);
  }
}
