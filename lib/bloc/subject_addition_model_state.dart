part of 'subject_addition_model_bloc.dart';

@immutable
abstract class SubjectAdditionModelState extends Equatable {
  const SubjectAdditionModelState();

  @override
  List<Object> get props => [];
}

class SubjectAdditionModelInitialState extends SubjectAdditionModelState {}

class SubjectAdditionModelLoadingState extends SubjectAdditionModelState {}

class SubjectAdditionModelLoadedState extends SubjectAdditionModelState {
  final List<MySubjectOverall> apiSubjectResult;

  const SubjectAdditionModelLoadedState(
    this.apiSubjectResult,
  );
}

class SubjectAdditionModelErrorState extends SubjectAdditionModelState {
  final String error;

  const SubjectAdditionModelErrorState(
    this.error,
  );
}
