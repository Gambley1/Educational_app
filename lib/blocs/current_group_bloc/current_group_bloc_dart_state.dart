part of 'current_group_bloc_dart_bloc.dart';

@immutable
abstract class CurrentGroupState extends Equatable {
  const CurrentGroupState();

  @override
  List<Object> get props => [];
}

class CurrentGroupLoadingState extends CurrentGroupState {}

class CurrentGroupLoadedState extends CurrentGroupState {
  final GroupModel group;

  const CurrentGroupLoadedState({required this.group});

  @override
  List<Object> get props => [group];
}

class CurrentGroupErrorState extends CurrentGroupState {}

class CurrentGroupNoInternteState extends CurrentGroupState {}
