part of 'folders_cubit_cubit.dart';

@immutable
abstract class FoldersState {}

class FoldersInitial extends FoldersState {}

class FoldersSuccess extends FoldersState {}

class NotesOfFolderSuccess extends FoldersState {}

class AddNoteFolderSuccess extends FoldersState {}

class DeleteSelectedFoldersSuccess extends FoldersState {}

class DeleteSelectedFoldersFailure extends FoldersState {
  final String errMessage;

  DeleteSelectedFoldersFailure(this.errMessage);
}

class SelectFolder extends FoldersState {}
