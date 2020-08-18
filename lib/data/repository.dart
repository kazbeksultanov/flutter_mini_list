import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_list/blocs/list/bloc.dart';
import 'package:flutter_mini_list/data/models.dart';
import 'package:flutter_mini_list/ui/home_page.dart';
import 'package:get_it/get_it.dart';

Future setUP(BuildContext context) async {
  print("Started app data setUP");
//  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await Future.delayed(Duration(seconds: 2));
  GetIt.instance.registerSingleton<AppBackend>(
    AppBackend(
      mockData,
      durationForFetches: Duration(seconds: 1),
    ),
  );
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
      builder: (context) => HomePage(),
    ),
  );
  print("Then Here");
}

List<ToDoItem> mockData = [
  ToDoItem(
    id: 0,
    title: "Do hw",
    text: "Here hw this",
  ),
  ToDoItem(
    id: 1,
    title: "Do clean",
    text: "Here clean this",
  ),
  ToDoItem(
    id: 2,
    title: "Do Exercise",
    text: "Here Exercise 10 push ups",
  ),
];

class AppBackend {
  List<ToDoItem> _todoList;
  final Duration durationForFetches;
  bool showReverse;

  AppBackend(
    this._todoList, {
    this.durationForFetches,
    this.showReverse = false,
  });

  Future<List<ToDoItem>> fetchData() async {
    await Future.delayed(durationForFetches);
    return _todoList;
  }

  Future<List<ToDoItem>> addData({
    @required String title,
    @required String text,
  }) async {
    try {
      await Future.delayed(durationForFetches);
      _todoList.add(ToDoItem(
        id: _todoList.length,
        title: title,
        text: text,
      ));
      return _todoList;
    } catch (e) {
      return _todoList;
    }
  }

  Future<List<ToDoItem>> deleteData({@required ToDoItem toDoItem}) async {
    try {
      await Future.delayed(durationForFetches);
      _todoList.remove(toDoItem);
      return _todoList;
    } catch (e) {
      return _todoList;
    }
  }


  Future<bool> reverseOrder() async {
    try {
      await Future.delayed(durationForFetches);
      _todoList = _todoList.reversed.toList();
      return true;
    } catch (e) {
      return false;
    }
  }
}
