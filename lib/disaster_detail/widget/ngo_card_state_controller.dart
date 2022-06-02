import 'package:help_on_needs/bloc/bloc.dart';

class NgoCardController extends Bloc<NgoBlocModel> {
  @override
  NgoBlocModel initDefaultValue() {
    return NgoBlocModel(isExpanded: false);
  }

  void toggle() {
    state.isExpanded = !state.isExpanded;
    emit(state);
  }
}

class NgoBlocModel {
  bool isExpanded;
  NgoBlocModel({required this.isExpanded});
}
