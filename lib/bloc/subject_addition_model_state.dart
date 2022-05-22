part of 'subject_addition_model_bloc.dart';

abstract class SubjectAdditionModelState {}

class SubjectAdditionModelInitialState extends SubjectAdditionModelState {}

class SubjectAdditionModelLoadingState extends SubjectAdditionModelState {}

class SubjectAdditionModelLoadedState extends SubjectAdditionModelState {
  final List<MySubjectOverall> apiSubjectResult;

  SubjectAdditionModelLoadedState(
    this.apiSubjectResult,
  );
}

class SubjectAdditionModelErrorState extends SubjectAdditionModelState {}
