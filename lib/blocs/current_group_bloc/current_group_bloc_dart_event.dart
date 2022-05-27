part of 'current_group_bloc_dart_bloc.dart';

abstract class CurrentGroupEvent extends Equatable {
  const CurrentGroupEvent();

  @override
  List<Object> get props => [];
}

class LoadCurrentGroupEvent extends CurrentGroupEvent {}

class NoInternetCurrentGroupEvent extends CurrentGroupEvent {}
