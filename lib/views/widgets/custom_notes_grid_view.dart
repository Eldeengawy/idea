import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:idea/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/edit_note_view.dart';
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
    BlocProvider.of<NotesCubit>(context).fetchAllNotes();

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

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BlocBuilder<NotesCubit, NotesState>(
          builder: (context, state) {
            List<NoteModel> notes =
                BlocProvider.of<NotesCubit>(context).notes ?? [];
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: notes.length,
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return Hero(
                  tag: notes[index].title!,
                  child: NoteWidget(
                    note: notes[index],
                  ),
                );
              },
            );
          },
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
            NoteModel note = NoteModel(
                title: title,
                content: content,
                color: color.value,
                date: DateTime.now().toString());

            setState(() {
              // notes.add(note);
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
  // final String? title;
  // final String? content;
  // final Color? color;
  final NoteModel? note;

  const NoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final int backgroundColor = note!.color ??
        (Theme.of(context).textTheme.titleLarge?.color == Colors.white
            ? const Color(0xff17181a)
                .value // Dark theme primary text color is white
            : Colors.white.value);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditNoteView(
                      note: note,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              Theme.of(context).textTheme.titleLarge?.color == Colors.black
                  ? BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(
                          0, 2), // Adjust the position of the shadow
                    )
                  : const BoxShadow(),
            ],
            color: Color(backgroundColor),
            borderRadius: BorderRadius.circular(30.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                note!.title!,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 18,
                    // color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                note!.content!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 14,
                      // color:  Colors.white.withOpacity(0.6)
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
                      // note!.date!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            // color:  Colors.white.withOpacity(0.6)
                          ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
