import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'change_mode_state.dart';

class ChangeModeCubit extends Cubit<ChangeModeState> {
  ChangeModeCubit() : super(ChangeModeInitial());
  static ChangeModeCubit get(context) => BlocProvider.of(context);
  bool isDarkMode =
      true; // This is not related to the font, just leaving it as it is.
  void toggleMode() {
    isDarkMode = !isDarkMode;
    emit(SwitchModeState());
  }
}
