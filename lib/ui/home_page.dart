import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_list/blocs/bloc.dart';
import 'package:flutter_mini_list/data/models.dart';

class HomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mini ToDo List"),
      ),
      body: _MainBody(),
      floatingActionButton: _Fab(
        titleController: titleController,
        textController: textController,
        listBloc: BlocProvider.of<ListBloc>(context),
      ),
    );
  }
}

class _Fab extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController textController;
  final ListBloc listBloc;

  const _Fab(
      {Key key,
      @required this.titleController,
      @required this.textController,
      @required this.listBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("New ToDo"),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: titleController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        enabled: true,
                        decoration: InputDecoration.collapsed(hintText: "Title"),
                      ),
                      TextField(
                        controller: textController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        enabled: true,
                        decoration: InputDecoration.collapsed(hintText: "Text"),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"),
                  ),
                  FlatButton(
                    onPressed: () async {
                      listBloc.add(AddNewTodoListEvent(
                        title: titleController.text,
                        text: textController.text,
                      ));
                      titleController.clear();
                      textController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text("Save"),
                  ),
                ],
              );
            });
      },
      child: Icon(Icons.add),
    );
  }
}

class _MainBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (BuildContext context, state) {
        if (state is LoadingListState || state is InitialListState) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoadedListState) {
          return Container(
            child: ListView.builder(
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return _ToDoItemCard(
                  toDoItem: state.list[index],
                  count: index,
                );
              },
            ),
          );
        }

        if(state is NoContentListState){
          return Container(
            child: Center(
              child: Text("Add New ToDo to show"),
            ),
          );
        }

        return Container(
          child: Center(
            child: Text("Error"),
          ),
        );
      },
    );
  }
}

class _ToDoItemCard extends StatelessWidget {
  final ToDoItem toDoItem;
  final int count;

  const _ToDoItemCard({
    Key key,
    @required this.toDoItem,
    @required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          _Count(count: count),
          Expanded(
            child: _MainText(
              title: toDoItem.title,
              text: toDoItem.text,
            ),
          ),
          _DeleteButton(toDoItem: toDoItem),
        ],
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final ToDoItem toDoItem;

  const _DeleteButton({Key key, @required this.toDoItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.delete),
      onPressed: () {
        print("Delete todo item ${toDoItem.title}");
        BlocProvider.of<ListBloc>(context).add(DeleteTodoListEvent(toDoItem: toDoItem));
      },
    );
  }
}

class _MainText extends StatelessWidget {
  final String title;
  final String text;

  const _MainText({
    Key key,
    @required this.title,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class _Count extends StatelessWidget {
  final int count;

  const _Count({Key key, @required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 4, right: 8),
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Text(
        count.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}
