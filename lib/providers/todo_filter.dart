// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

import 'package:todo_app/models/todo_model.dart';

class TodoFilterState extends Equatable {
  final Filter filter;

  const TodoFilterState({
    required this.filter,
  });

  factory TodoFilterState.initial() {
    return const TodoFilterState(filter: Filter.all);
  }

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;

  TodoFilterState copyWith({
    Filter? filter,
  }) {
    return TodoFilterState(
      filter: filter ?? this.filter,
    );
  }
}

/*class TodoFilter with ChangeNotifier {
  TodoFilterState _state = TodoFilterState.initial();

  TodoFilterState get state => _state;

  void changeFilter(Filter newFilter) {
    print(newFilter);
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}*/

/* Refactoring using StateProvider */
class TodoFilter extends StateNotifier<TodoFilterState> {
  TodoFilter() : super(TodoFilterState.initial());

  void changeFilter(Filter newFilter) {
    state = state.copyWith(filter: newFilter);
  }
}
