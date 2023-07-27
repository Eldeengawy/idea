import 'package:flutter/material.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/edit_view_body.dart';

class EditNoteView extends StatelessWidget {
  final Note? note;
  const EditNoteView({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1b1b1f),
      body: Hero(
        tag: note!.title!,
        child: EditNoteViewBody(
          note: note,
        ),
      ),
    );
  }
}
