import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idea/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/edit_note_view.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel? note;

  const NoteWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int backgroundColor = note!.color ??
        (Theme.of(context).textTheme.titleLarge?.color == Colors.white
            ? const Color(0xff17181a)
                .value // Dark theme primary text color is white
            : Colors.white.value);

    void _showDeleteConfirmationDialog() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Delete Note',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            content: Text(
              'Are you sure you want to delete this note?',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                  ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Cancel button
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Perform the delete operation here
                  // For this example, let's assume the delete method is defined in the NotesCubit
                  // BlocProvider.of<NotesCubit>(context).deleteNote(note);
                  note!.delete();
                  BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('Delete'),
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNoteView(
              note: note,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            Theme.of(context).textTheme.titleLarge?.color == Colors.black
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset:
                        const Offset(0, 2), // Adjust the position of the shadow
                  )
                : const BoxShadow(),
          ],
          color: Color(backgroundColor),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 110,
                    child: Text(
                      note!.title!,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: _showDeleteConfirmationDialog,
                    icon: Icon(
                      FeatherIcons.delete,
                      color: Colors.redAccent.withOpacity(0.4),
                      size: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note!.content!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                    ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      note!.date!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
