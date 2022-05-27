import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:educational_app/services/api_request_service/group_service.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/models.dart';
import '../../../services/connectivity_service/connectivity_service.dart';

part 'current_group_bloc_dart_event.dart';
part 'current_group_bloc_dart_state.dart';

class CurrentGroupBloc extends Bloc<CurrentGroupEvent, CurrentGroupState> {
  final ConnectivityService _connectivityService;
  final GroupService _groupService;
  late StreamSubscription _streamSubscription;
  CurrentGroupBloc(this._connectivityService, this._groupService)
      : super(CurrentGroupLoadingState()) {
    _streamSubscription = _connectivityService.connectivityStream.stream.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          add(NoInternetCurrentGroupEvent());
        } else {
          add(LoadCurrentGroupEvent());
        }
      },
    );
    on<LoadCurrentGroupEvent>((event, emit) async {
      emit(CurrentGroupLoadingState());
      try {
        final group = await _groupService.getCurrentGroup();
        emit(CurrentGroupLoadedState(group: group));
      } catch (e) {
        emit(CurrentGroupErrorState());
      }
    });
    on<NoInternetCurrentGroupEvent>(
      (event, emit) {
        emit(CurrentGroupNoInternteState());
      },
    );
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
