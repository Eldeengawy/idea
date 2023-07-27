import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
// ANSI escape sequence for orange color
  static const String _orangeColor = '\u001b[38;5;208m';

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('${_orangeColor}onCreate -- ${bloc.runtimeType}\u001b[0m');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${_orangeColor}onChange -- ${bloc.runtimeType}, $change\u001b[0m');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${_orangeColor}onError -- ${bloc.runtimeType}, $error\u001b[0m');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('${_orangeColor}onClose -- ${bloc.runtimeType}\u001b[0m');
  }
}
