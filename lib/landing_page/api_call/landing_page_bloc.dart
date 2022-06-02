import 'package:help_on_needs/bloc/bloc.dart';
import 'package:help_on_needs/landing_page/api_call/landing_page_http_service.dart';
import 'package:help_on_needs/landing_page/api_call/landing_page_query.dart';
import 'package:help_on_needs/landing_page/models/landing_page_model.dart';

class LandingPageBloc extends Bloc<LandingPageViewModel> {
  @override
  LandingPageViewModel initDefaultValue() {
    return LandingPageViewModel(state: LandingPageState.inital);
  }

  void getScreenData(int type) async {
    state.state = LandingPageState.loading;
    emit(state);
    LandingPageModel? response =
        await LandingHttpServiceApi().posts(LandingPageQuery.getQuery(type));

    if (response != null && response.disasterList != null) {
      if (response.disasterList!.isEmpty) {
        state.state = LandingPageState.empty;
        emit(state);
        return;
      }
      state.disasterList = response;
      state.state = LandingPageState.success;
      emit(state);
      return;
    } else {
      state.state = LandingPageState.failure;
      emit(state);
      return;
    }
  }
}

class LandingPageViewModel {
  LandingPageState state;
  LandingPageModel? disasterList;
  LandingPageViewModel({
    required this.state,
    this.disasterList,
  });
}

enum LandingPageState { inital, loading, success, failure, empty }
