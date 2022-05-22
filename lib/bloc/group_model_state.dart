part of 'group_model_bloc.dart';

abstract class GroupModelState {}

class GroupModelInititalState extends GroupModelState {}

class GroupModelLoadingState extends GroupModelState {}

class GroupModelLoadedState extends GroupModelState {
  final List<GroupModel> apiResult;
  GroupModelLoadedState(
    this.apiResult,
  );
}

class GroupModelErrorState extends GroupModelState {}
