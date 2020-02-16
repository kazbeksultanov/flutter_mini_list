import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_mini_list/data/models.dart';
import 'package:flutter_mini_list/data/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:get_it/get_it.dart';
import './bloc.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  @override
  ListState get initialState => InitialListState();

  @override
  Stream<ListState> transformEvents(
    Stream<ListEvent> events,
    Stream<ListState> Function(ListEvent) next,
  ) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 300)), next);
  }

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    final currentState = state;
    if (event is RefreshListEvent || currentState is InitialListState) {
      try {
        yield LoadingListState();
        List<ToDoItem> list = await GetIt.instance<AppBackend>().fetchData();
        if (list.length > 0) {
          yield LoadedListState(list: list);
        } else {
          yield NoContentListState();
        }
      } catch (_) {
        yield ErrorListState();
      }
    }

    if (event is AddNewTodoListEvent) {
      yield LoadingListState();

      String title = event.props[0] as String;
      String text = event.props[1] as String;

      List<ToDoItem> refreshedList = await GetIt.instance<AppBackend>().addData(
        title: title,
        text: text,
      );
      yield LoadedListState(list: refreshedList);
    }

    if (event is DeleteTodoListEvent) {
      yield LoadingListState();
      List<ToDoItem> refreshedList = await GetIt.instance<AppBackend>().deleteData(
        toDoItem: event.props[0] as ToDoItem,
      );
      if(refreshedList.length > 0){
        yield LoadedListState(list: refreshedList);
      } else {
        yield NoContentListState();
      }

    }
  }
}
