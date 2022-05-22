import 'package:bloc/bloc.dart';
import 'package:educational_app/models/subject_additional_model.dart';

import 'package:educational_app/services/api_request_service/subject_service.dart';
import 'package:educational_app/services/controller/base_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'subject_addition_model_event.dart';
part 'subject_addition_model_state.dart';

class SubjectAdditionModelBloc
    extends Bloc<SubjectAdditionModelEvent, SubjectAdditionModelState>
    with BaseController {
  SubjectAdditionModelBloc(SubjectService subjectService)
      : super(SubjectAdditionModelInitialState()) {
    on<SubjectAdditionModelEvent>((event, emit) async {
      emit(SubjectAdditionModelInitialState());
      try {
        var listIsEmpty = 'Вы не состоите ни в одной группе';
        List<MySubjectOverall>? apiSubjectResult =
            await SubjectService().getListOfSubjects();
        if (apiSubjectResult.isNotEmpty) {
          emit(
            SubjectAdditionModelLoadedState(apiSubjectResult),
          );
        } else {
          emit(SubjectAdditionModelErrorState(listIsEmpty));
        }
      } catch (e) {
        emit(
          SubjectAdditionModelErrorState(
            e.toString(),
          ),
        );
      }
    });
  }
}
