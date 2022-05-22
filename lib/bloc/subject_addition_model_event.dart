part of 'subject_addition_model_bloc.dart';

abstract class SubjectAdditionModelEvent extends Equatable {
  const SubjectAdditionModelEvent();

  @override
  List<Object> get props => [];
}

class LoadSubjectAdditionModelEvent extends SubjectAdditionModelEvent {}
