import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/folder_model.dart';
import 'package:meta/meta.dart';

part 'folders_cubit_state.dart';

class FoldersCubit extends Cubit<FoldersState> {
  FoldersCubit() : super(FoldersInitial());
  List<FolderModel>? folders;
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
}
