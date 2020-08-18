import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SettingsEvent extends Equatable {}


class OnChangeReverseSettingsEvent extends SettingsEvent {
  final bool isReverse;

  OnChangeReverseSettingsEvent({this.isReverse});
  @override
  List<Object> get props => [isReverse];
}