import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/notes_cubit/notes_cubit_cubit.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/custom_notes_grid_view.dart';
import 'package:idea/views/widgets/folders_screen.dart';

class PageViewWithToggleButtons extends StatefulWidget {
  const PageViewWithToggleButtons({Key? key}) : super(key: key);

  @override
  _PageViewWithToggleButtonsState createState() =>
      _PageViewWithToggleButtonsState();
}

final PageController _pageController = PageController(initialPage: 0);

class _PageViewWithToggleButtonsState extends State<PageViewWithToggleButtons> {
  // final int _currentPageIndex = 0;
  int selectedIndex = 0;
  // final _coastController = CoastController();
  // final _beaches = [
  //   Beach(builder: (context) => const NotesStaggeredGrid()),
  //   Beach(builder: (context) => const FoldersScreen()),
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildButton(0, 'All Notes'),
            _buildButton(1, 'Folders'),
          ],
        ),
        // const SizedBox(
        //   height: 20,
        // ),
        // Expanded(
        //   child: Coast(
        //     beaches: _beaches,
        //     controller: _coastController,
        //     onPageChanged: (index) {
        //       setState(() {
        //         // _currentPageIndex = index;
        //         selectedIndex =
        //             index; // Update selectedIndex to sync with PageView index
        //       });
        //     },
        //     observers: [
        //       CrabController(),
        //     ],
        //   ),
        // ),
        Expanded(
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                // _currentPageIndex = index;
                selectedIndex =
                    index; // Update selectedIndex to sync with PageView index
              });
            },
            children: [
              // Screen 1 (All Notes),
              BlocBuilder<NotesCubit, NotesState>(builder: (context, state) {
                List<NoteModel> notes =
                    BlocProvider.of<NotesCubit>(context).notes ?? [];
                return NotesStaggeredGrid(
                  notes: notes,
                  onTapButton: () {},
                  folderName: '',
                );
              }),

              // Screen 2 (Folders),
              const FoldersScreen(),
            ],
          ),
        ),
      ],
    );
  }

  //  BlocBuilder<NotesCubit, NotesState>(
  //         builder: (context, state) {
  //           List<NoteModel> notes =
  //               BlocProvider.of<NotesCubit>(context).notes ?? [];

  Widget _buildButton(int index, String text) {
    final isSelected = selectedIndex == index;
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          if (selectedIndex != index) {
            selectedIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xffff9e37) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected
                ? Theme.of(context).textTheme.titleLarge?.color
                : Colors.grey[600],
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
