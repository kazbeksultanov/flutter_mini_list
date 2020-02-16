import 'package:equatable/equatable.dart';

class ToDoItem extends Equatable {
  final int id;
  final String title;
  final String text;

  const ToDoItem({
    this.id,
    this.title,
    this.text,
  });

  ToDoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        text = json['text'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': title,
        'email': text,
      };

  @override
  List<Object> get props => [id, title, text];
}
