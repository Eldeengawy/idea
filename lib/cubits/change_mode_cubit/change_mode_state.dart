part of 'change_mode_cubit.dart';

@immutable
abstract class ChangeModeState {}

class ChangeModeInitial extends ChangeModeState {}

class SwitchModeState extends ChangeModeState {}
// class DarkMode extends ChangeModeState {}

// class LightMode extends ChangeModeState {}
