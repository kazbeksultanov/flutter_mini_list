import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mini_list/blocs/list/bloc.dart';
import 'package:flutter_mini_list/data/repository.dart';
import 'package:get_it/get_it.dart';
import './bloc.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ListBloc listBloc;

  SettingsBloc({@required this.listBloc}) : assert(listBloc != null);

  @override
  SettingsState get initialState => InitialSettingsState();

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    if (event is OnChangeReverseSettingsEvent) {
      GetIt.instance<AppBackend>().showReverse = !GetIt.instance<AppBackend>().showReverse;
      await GetIt.instance<AppBackend>().reverseOrder();
      listBloc.add(RefreshListEvent());
      yield SettingChangedSettingsState();
    }
  }
}
