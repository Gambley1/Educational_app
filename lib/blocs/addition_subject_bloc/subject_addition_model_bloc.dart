import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:educational_app/services/api_request_service/subject_service.dart';
import 'package:educational_app/services/connectivity_service/connectivity_service.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/models.dart';

part 'subject_addition_model_event.dart';
part 'subject_addition_model_state.dart';

class SubjectAdditionModelBloc
    extends Bloc<SubjectAdditionModelEvent, SubjectAdditionModelState> {
  final ConnectivityService _connectivityService;
  final SubjectService _subjectService;
  late StreamSubscription _streamSubscription;
  SubjectAdditionModelBloc(this._connectivityService, this._subjectService)
      : super(SubjectAdditionModelLoadingState()) {
    _streamSubscription = _connectivityService.connectivityStream.stream.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          add(NoInternetEvent());
        } else {
          add(LoadSubjectAdditionModelEvent());
        }
      },
    );
    on<LoadSubjectAdditionModelEvent>(
      (event, emit) async {
        emit(
          SubjectAdditionModelLoadingState(),
        );
        try {
          final subjects = await _subjectService.getListOfSubjects();
          emit(
            SubjectAdditionModelLoadedState(
              subjectOverall: subjects,
            ),
          );
        } catch (e) {
          emit(const SubjectAdditionModelErrorState());
        }
      },
    );
    on<NoInternetEvent>(
      (event, emit) {
        emit(SubjectAdditionModelNoInternetState());
      },
    );
    on<RefreshEvent>((event, emit) async {
      emit(SubjectAdditionModelRefreshingState());
      final subjects = await _subjectService.getListOfSubjects();
      emit(SubjectAdditionModelLoadingState());
      emit(
        SubjectAdditionModelLoadedState(subjectOverall: subjects),
      );
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
