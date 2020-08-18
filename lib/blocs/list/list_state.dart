import 'package:equatable/equatable.dart';
import 'package:flutter_mini_list/data/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListState extends Equatable {}

class InitialListState extends ListState {
  @override
  List<Object> get props => null;
}

class LoadingListState extends ListState {
  @override
  List<Object> get props => null;
}

class NoContentListState extends ListState {
  @override
  List<Object> get props => null;
}

class ErrorListState extends ListState {
  @override
  List<Object> get props => null;
}

class LoadedListState extends ListState {
  final List<ToDoItem> list;

  LoadedListState({this.list});

  @override
  List<Object> get props => [list];

  @override
  String toString() {
    return "LoadedListState {list.length: ${list.length}";
  }
}
