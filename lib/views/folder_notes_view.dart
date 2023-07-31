import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/custom_app_bar.dart';
import 'package:idea/views/widgets/custom_notes_grid_view.dart';
import 'package:idea/views/widgets/custom_search_widget.dart';

class FolderNotesView extends StatelessWidget {
  const FolderNotesView({super.key, required this.folder});
  final FolderModel folder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FolderNotesViewBody(folder: folder),
    );
  }
}

class FolderNotesViewBody extends StatelessWidget {
  const FolderNotesViewBody({super.key, required this.folder});
  final FolderModel folder;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomAppBar(
                title: '${folder.name} Notes',
                isWithIcon: false,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const CustomSearchWidget(),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: BlocBuilder<FoldersCubit, FoldersState>(
                    builder: (context, state) {
                  List<NoteModel> notes = BlocProvider.of<FoldersCubit>(context)
                      .fetchNotesForFolder(folder);
                  return NotesStaggeredGrid(
                    notes: notes,
                    onTapButton: () {},
                    folderName: '${folder.name}',
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
