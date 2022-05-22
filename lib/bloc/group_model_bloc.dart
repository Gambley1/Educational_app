import 'package:bloc/bloc.dart';
import 'package:educational_app/models/group_model.dart';
import 'package:educational_app/services/api_request_service/group_service.dart';

part 'group_model_event.dart';
part 'group_model_state.dart';

class GroupModelBloc extends Bloc<GroupModelEvent, GroupModelState> {
  final GroupService groupService;

  GroupModelBloc(
    this.groupService,
  ) : super(GroupModelInititalState()) {
    on<GroupModelEvent>((event, emit) async {
      if (event is LoadGroupModelEvent) {
        emit(GroupModelLoadingState());
        List<GroupModel>? apiResult = await groupService.getListOfGroups();
        if (apiResult == null) {
          emit(GroupModelErrorState());
        } else {
          emit(GroupModelLoadedState(apiResult));
        }
      }
    });
  }
}
