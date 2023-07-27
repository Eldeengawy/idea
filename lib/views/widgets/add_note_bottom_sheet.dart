import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:idea/views/widgets/add_note_form.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class AddNoteBottomSheet extends StatelessWidget {
  final void Function(
      String title, String content, Color color, String folderName) onAddFolder;

  const AddNoteBottomSheet({Key? key, required this.onAddFolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600, // Specify your desired fixed height here
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteFailure) {
            if (kDebugMode) {
              print('Failed ${state.errMessage}');
            }
          }

          if (state is AddNoteSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
              inAsyncCall: state is AddNoteLoading ? true : false,
              child: AddNoteForm(onAddFolder: onAddFolder));
        },
      ),
    );
  }
}
