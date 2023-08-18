import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/views/widgets/add_note_to_folder_form.dart';

class AddNoteToFolderBottomSheet extends StatelessWidget {
  final String folderName;
  // final void Function(
  //     String title, String content, Color color, String folderName) onAddFolder;

  const AddNoteToFolderBottomSheet({
    Key? key,
    required this.folderName,
    // required this.onAddFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoldersCubit(),
      child: BlocConsumer<FoldersCubit, FoldersState>(
        listener: (context, state) {},
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddNoteLoading ? true : false,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddNoteToFolderForm(folderName: folderName),
            ),
          );
        },
      ),
    );
  }
}
