import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mini_list/blocs/settings/bloc.dart';
import 'package:flutter_mini_list/data/repository.dart';
import 'package:get_it/get_it.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Reverse list:"),
                Switch(
                  value: GetIt.instance<AppBackend>().showReverse,
                  onChanged: (bool val) {
                    BlocProvider.of<SettingsBloc>(context).add(OnChangeReverseSettingsEvent());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
