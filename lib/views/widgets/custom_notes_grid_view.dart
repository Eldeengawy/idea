import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idea/views/models/note_model.dart';
import 'package:idea/views/widgets/add_note_bottom_sheet.dart';
import 'package:idea/views/widgets/custom_circular_button.dart';

class NotesStaggeredGrid extends StatefulWidget {
  const NotesStaggeredGrid({super.key});

  @override
  State<NotesStaggeredGrid> createState() => _NotesStaggeredGridState();
}

class _NotesStaggeredGridState extends State<NotesStaggeredGrid> {
  final List<Note> notes = [
    Note(
      title: "What is Lorem Ipsum?",
      content:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
    ),
    Note(
      title: "Why do we use it?",
      content: "This is the content of Note 2. It has a longer text.",
    ),
    Note(
      title: "Note 3",
      content: "Short content.",
    ),
    Note(
      title: "Where does it come from?",
      content:
          'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
    ),
    Note(
      title: "Note 5",
      content:
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here',",
    ),
    Note(
      title: "Note 6",
      content:
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here',",
    ),
    Note(
      title: "Note 7",
      content: "Short content.",
    ),
    Note(
      title: "Note 8",
      content: "Short content.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return NoteWidget(
                title: notes[index].title,
                content: notes[index].content,
                // color: const Color(0xffda892b),
                color: notes[index].color ?? const Color(0xff17181a),
              );
            },
          ),
        ),
        CustomCircularButton(
          onTapFunction: () => showAddFolderBottomSheet(context),
          title: 'Add New Note',
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  showAddFolderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddNoteBottomSheet(
          onAddFolder:
              (String title, String content, Color color, String folderName) {
            Note note = Note(title: title, content: content, color: color);

            setState(() {
              notes.add(note);
            });
            // Navigator.pop(
            //     context); // Close the bottom sheet after adding folder
          },
        );
      },
    );
  }
}

class NoteWidget extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? color;

  const NoteWidget({super.key, this.title, this.content, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(30.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title!,
              style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              content!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
