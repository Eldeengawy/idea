part of 'add_folder_cubit.dart';

@immutable
abstract class AddFolderState {}

class AddFolderInitial extends AddFolderState {}

class AddFolderLoading extends AddFolderState {}

class AddFolderSuccess extends AddFolderState {}

class AddFolderFailure extends AddFolderState {
  final String errMessage;

  AddFolderFailure(this.errMessage);
}
