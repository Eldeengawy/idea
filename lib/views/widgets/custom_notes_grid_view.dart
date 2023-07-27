import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idea/views/edit_note_view.dart';
import 'package:idea/views/models/note_model.dart';
import 'package:idea/views/widgets/add_note_bottom_sheet.dart';
import 'package:idea/views/widgets/custom_circular_button.dart';

class NotesStaggeredGrid extends StatefulWidget {
  const NotesStaggeredGrid({super.key});

  @override
  State<NotesStaggeredGrid> createState() => _NotesStaggeredGridState();
}

class _NotesStaggeredGridState extends State<NotesStaggeredGrid> {
  bool _isButtonVisible = true; // Initial state, the button is visible

  @override
  void initState() {
    super.initState();

    // Add a listener to the ScrollController
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // Remember to dispose of the ScrollController when it's no longer needed
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check the scroll position and decide whether to show or hide the button
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      // User is scrolling up, show the button
      setState(() {
        _isButtonVisible = true;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // User is scrolling down, hide the button
      setState(() {
        _isButtonVisible = false;
      });
    }
  }

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
    Note(
      title: "Note 9",
      content:
          "t is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here',",
    ),
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Expanded(
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: notes.length,
            controller: _scrollController,
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
        // if (_isButtonVisible)
        Positioned(
          bottom: 20.0,
          left: screenWidth / 6,
          child: Crab(
            tag: 'addButton',
            child: CustomCircularButton(
              onTapFunction: () => showAddFolderBottomSheet(context),
              title: 'Add New Note',
              isButtonVisible: _isButtonVisible,
            ),
          ),
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
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EditNoteView()));
      },
      child: Container(
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
      ),
    );
  }
}
