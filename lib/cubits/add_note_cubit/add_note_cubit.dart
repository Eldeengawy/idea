import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/models/note_model.dart';
import 'package:meta/meta.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  // Future<void> addNote(NoteModel note) async {
  //   emit(AddNoteLoading());
  //   try {
  //     var notesBox = Hive.box<NoteModel>(kNotesBox);
  //     await notesBox.add(note);
  //     // var folderBox = Hive.box<FolderModel>(kFoldersBox);
  //     // Here i need to add the note the folder

  //     emit(AddNoteSuccess());
  //   } catch (e) {
  //     emit(AddNoteFailure(e.toString()));
  //   }
  // }
  String selectedfolder = '';

  Future<void> addNote(NoteModel note) async {
    emit(AddNoteLoading());
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      await notesBox.add(note);

      var folderBox = Hive.box<FolderModel>(kFoldersBox);
      String selectedFolderName = note
          .folderName!; // Assuming folderName is a property of the NoteModel

      // Find the folder with the selected folder name
      FolderModel? selectedFolder;
      for (var folder in folderBox.values) {
        if (folder.name == selectedfolder) {
          selectedFolder = folder;
          break;
        }
      }

      if (selectedFolder != null) {
        // Add the note to the folder's notes list
        selectedFolder.folderNotes
            ?.add(note); // Make sure folderNotes list is not null

        // Save the updated folder back to the box
        await selectedFolder.save();
      } else {
        // Handle the case where the selected folder is not found (optional)
        print('Selected folder not found: $selectedFolderName');
      }

      emit(AddNoteSuccess());
    } catch (e) {
      emit(AddNoteFailure(e.toString()));
    }
  }
}
