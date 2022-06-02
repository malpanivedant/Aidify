import 'package:help_on_needs/bloc/bloc.dart';
import 'package:help_on_needs/disaster_detail/api_call/details_page_http_service.dart';
import 'package:help_on_needs/disaster_detail/models/details_page_model.dart';

class DetailsPageBloc extends Bloc<DetailsPageViewModel> {
  @override
  DetailsPageViewModel initDefaultValue() {
    return DetailsPageViewModel(state: DetailsPageState.inital);
  }

  void getScreenData(String? id) async {
    if (id == null || id.isEmpty) {
      state.state = DetailsPageState.failure;
      emit(state);
      return;
    }
    state.state = DetailsPageState.loading;
    emit(state);
    DetailsPageModel? response = await DetailsHttpServiceApi().gets(id);
    if (response != null &&
        response.organizations != null &&
        response.organizations!.isNotEmpty) {
      state.data = response;
      state.state = DetailsPageState.success;
      emit(state);
      return;
    } else {
      state.state = DetailsPageState.failure;
      emit(state);
      return;
    }
  }
}

class DetailsPageViewModel {
  DetailsPageState state;
  DetailsPageModel? data;
  DetailsPageViewModel({
    required this.state,
    this.data,
  });
}

enum DetailsPageState { inital, loading, success, failure }
