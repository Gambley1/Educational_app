part of 'subject_addition_model_bloc.dart';

@immutable
abstract class SubjectAdditionModelState extends Equatable {
  const SubjectAdditionModelState();

  @override
  List<Object> get props => [];
}

class SubjectAdditionModelLoadingState extends SubjectAdditionModelState {}

class SubjectAdditionModelLoadedState extends SubjectAdditionModelState {
  final List<MySubjectOverall> subjectOverall;

  const SubjectAdditionModelLoadedState({
    required this.subjectOverall,
  });

  @override
  List<Object> get props => [subjectOverall];
}

class SubjectAdditionModelErrorState extends SubjectAdditionModelState {
  final String? error;

  const SubjectAdditionModelErrorState({
    this.error,
  });

  @override
  List<Object> get props => [];
}

class SubjectAdditionModelNoInternetState extends SubjectAdditionModelState {}

class SubjectAdditionModelRefreshingState extends SubjectAdditionModelState {}

