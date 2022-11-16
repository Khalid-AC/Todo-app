// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_app/providers/providers.dart';
import 'package:todo_app/providers/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;
  const ActiveTodoCountState({
    required this.activeTodoCount,
  });

  factory ActiveTodoCountState.initial() {
    return const ActiveTodoCountState(activeTodoCount: 0);
  }

  @override
  List<Object> get props => [activeTodoCount];

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }

  @override
  bool get stringify => true;
}

// Using ChangNotifierProxyProvider
/*class ActiveTodoCount with ChangeNotifier {
  //ActiveTodoCountState _state = ActiveTodoCountState.initial();
  late ActiveTodoCountState _state;
  ActiveTodoCountState get state => _state;

  final int initialActiveTodoCount;
  ActiveTodoCount({
    required this.initialActiveTodoCount,
  }) {
    _state = ActiveTodoCountState(activeTodoCount: initialActiveTodoCount);
  }

  void update(TodoList todoList) {
    final newActiveTodoCount =
        todoList.state.todos.where((todo) => !todo.isCompleted).toList().length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    notifyListeners();
  }
}*/

// Using Proxy Provider (because ActiveToDoCount state depends only on other states not on its own)
/*class ActiveTodoCount {
  final TodoList todoList;
  ActiveTodoCount({
    required this.todoList,
  });

  ActiveTodoCountState get state => ActiveTodoCountState(
      activeTodoCount: todoList.state.todos
          .where((todo) => !todo.isCompleted)
          .toList()
          .length);
}*/

class ActiveTodoCount extends StateNotifier<ActiveTodoCountState>
    with LocatorMixin {
  ActiveTodoCount() : super(ActiveTodoCountState.initial());

  @override
  void update(Locator watch) {
    final todos = watch<TodoListState>().todos;

    state = state.copyWith(
        activeTodoCount:
            todos.where((todo) => !todo.isCompleted).toList().length);
    super.update(watch);
  }
}
