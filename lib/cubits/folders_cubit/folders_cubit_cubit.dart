import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/models/note_model.dart';
import 'package:meta/meta.dart';

part 'folders_cubit_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit() : super(FoldersInitial());
  List<FolderModel>? folders;
  List<NoteModel>? folderNotes;
  List<FolderModel> selectedFolders = [];
  bool isSelectionOpened = false;
  fetchAllFolders() async {
    // try {
    var folderBox = Hive.box<FolderModel>(kFoldersBox);
    // List<NoteModel> notes = notesBox.values.toList();
    folders = folderBox.values.toList();
    //make folder notes list is equal to the list of notes in the model at the box
    emit(FoldersSuccess());
    // } catch (e) {
    //   emit(NotesFailure(e.toString()));
    // }
  }

  // Function to fetch notes for a specific folder
  List<NoteModel> fetchNotesForFolder(FolderModel folder) {
    try {
      var folderBox = Hive.box<FolderModel>(kFoldersBox);
      var folders = folderBox.values.toList();
      var index = folders.indexOf(folder);
      if (index == -1) {
        return []; // Folder not found, return an empty list
      }
      emit(NotesOfFolderSuccess());
      return folders[index].folderNotes ?? [];
    } catch (e) {
      // Handle any potential errors
      return []; // Return an empty list in case of an error
    }
  }

  // List<NoteModel> fetchNotesForFolder(context) {
  //   try {
  //     var folderBox = Hive.box<FolderModel>(kFoldersBox);
  //     var folders = folderBox.values.toList();
  //     var selectedFolderString =
  //         BlocProvider.of<AddNoteCubit>(context).selectedfolder;
  //     var selectedFolder = folderBox.values
  //         .firstWhere((folder) => folder.name == selectedFolderString);

  //     var index = folders.indexOf(selectedFolder);
  //     if (index == -1) {
  //       return []; // Folder not found, return an empty list
  //     }
  //     emit(NotesOfFolderSuccess());
  //     return folders[index].folderNotes ?? [];
  //   } catch (e) {
  //     // Handle any potential errors
  //     return []; // Return an empty list in case of an error
  //   }
  // }

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

  void addNoteToFolder(NoteModel newNote, FolderModel folder) {
    try {
      var folderBox = Hive.box<FolderModel>(kFoldersBox);
      var folders = folderBox.values.toList();
      var index = folders.indexOf(folder);

      if (index == -1) {
        emit(AddNoteToFolderFailure('Folder not found.'));
        return;
      }

      // Get the folder from the box and add the new note to its list of notes
      var updatedFolder = folders[index];
      updatedFolder.folderNotes ??= [];
      updatedFolder.folderNotes!.add(newNote);

      // Save the updated folder back to the Hive box
      folderBox.put(updatedFolder.key, updatedFolder);

      emit(AddNoteToFolderSuccess());
    } catch (e) {
      // Handle any potential errors
      emit(AddNoteToFolderFailure(e.toString()));
    }
  }
}
