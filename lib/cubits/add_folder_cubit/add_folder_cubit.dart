import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/folder_model.dart';
import 'package:meta/meta.dart';

part 'add_folder_state.dart';

class AddFolderCubit extends Cubit<AddFolderState> {
  AddFolderCubit() : super(AddFolderInitial());

  Future<void> addFolder(FolderModel folder) async {
    emit(AddFolderLoading());
    try {
      var foldersBox = Hive.box<FolderModel>(kFoldersBox);
      await foldersBox.add(folder);
      emit(AddFolderSuccess());
    } catch (e) {
      emit(AddFolderFailure(e.toString()));
      print(e.toString());
    }
  }
}
