import 'package:help_on_needs/bloc/bloc.dart';

class RadioButtonController extends Bloc<RatioButtonViewModel> {
  @override
  RatioButtonViewModel initDefaultValue() {
    return RatioButtonViewModel(isSelected: false);
  }

  void toggle() {
    state.isSelected = !state.isSelected;
    emit(state);
  }
}

class RatioButtonViewModel {
  bool isSelected;
  RatioButtonViewModel({required this.isSelected});
}
