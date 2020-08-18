import 'package:equatable/equatable.dart';
import 'package:flutter_mini_list/data/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListEvent extends Equatable {}

class RefreshListEvent extends ListEvent {
  @override
  List<Object> get props => null;
}

class AddNewTodoListEvent extends ListEvent {
  final String title;
  final String text;

  AddNewTodoListEvent({this.title, this.text});

  @override
  List<Object> get props => [title, text];
}

class DeleteTodoListEvent extends ListEvent {
  final ToDoItem toDoItem;

  DeleteTodoListEvent({this.toDoItem});

  @override
  List<Object> get props => [toDoItem];
}
