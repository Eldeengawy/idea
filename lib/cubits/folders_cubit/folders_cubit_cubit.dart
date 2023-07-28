import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/folder_model.dart';
import 'package:meta/meta.dart';

part 'folders_cubit_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit() : super(FoldersInitial());
  List<FolderModel>? folders;
  List<FolderModel> selectedFolders = [];
  bool isSelectionOpened = false;
  fetchAllFolders() async {
    // try {
    var folderBox = Hive.box<FolderModel>(kFoldersBox);
    // List<NoteModel> notes = notesBox.values.toList();
    folders = folderBox.values.toList();
    emit(FoldersSuccess());
    // } catch (e) {
    //   emit(NotesFailure(e.toString()));
    // }
  }

  deleteSelectedFolders() async {
    try {
      var folderBox = Hive.box<FolderModel>(kFoldersBox);
      for (var folder in selectedFolders) {
        await folderBox.delete(folder
            .key); // Replace 'key' with the actual unique identifier field in FolderModel
      }
      selectedFolders.clear();
      fetchAllFolders();
      isSelectionOpened = false;
      emit(DeleteSelectedFoldersSuccess());
    } catch (e) {
      // Handle any error that might occur during the delete process
      emit(DeleteSelectedFoldersFailure(e.toString()));
    }
  }

  selectFolder(folder) async {
    // try {
    if (selectedFolders.contains(folder)) {
      selectedFolders.remove(folder);
    } else {
      selectedFolders.add(folder);
      print(selectedFolders);
    }
    if (selectedFolders.isEmpty) {
      isSelectionOpened = false;
    }

    emit(SelectFolder());
  }
}
