import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/models/note_model.dart';
import 'package:meta/meta.dart';

part 'notes_cubit_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  fetchAllNotes() async {
    try {
      var notesBox = Hive.box<NoteModel>(kNotesBox);
      List<NoteModel> notes = notesBox.values.toList();
      emit(NotesSuccess(notes));
    } catch (e) {
      emit(NotesFailure(e.toString()));
    }
  }
}
