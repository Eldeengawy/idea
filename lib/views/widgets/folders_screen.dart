import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/views/folder_notes_view.dart';
import 'package:idea/views/widgets/add_folder_bottom_sheet.dart';
import 'package:idea/views/widgets/custom_circular_button.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  _FoldersScreenState createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  bool _isButtonVisible = true; // Initial state, the button is visible

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FoldersCubit>(context).fetchAllFolders();

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
            'Are you sure you want to delete ${BlocProvider.of<FoldersCubit>(context).selectedFolders.length} ${BlocProvider.of<FoldersCubit>(context).selectedFolders.length == 1 ? 'folder' : 'folders'}? ',
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
                // note!.delete();
                // BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                BlocProvider.of<FoldersCubit>(context).deleteSelectedFolders();
                _isButtonVisible = true;
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  final ScrollController _scrollController = ScrollController();
  bool _isGridView = true; // Initial state, grid view is enabled

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BlocBuilder<FoldersCubit, FoldersState>(
          builder: (context, state) {
            List<FolderModel> folders =
                BlocProvider.of<FoldersCubit>(context).folders ?? [];
            return GridView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: _isGridView ? 0.9 : 3,
              ),
              itemCount: folders.length,
              itemBuilder: (context, index) {
                return _buildFolderItem(folders[index]);
              },
            );
          },
        ),
        BlocConsumer<FoldersCubit, FoldersState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Positioned(
              bottom: 20.0,
              // left: screenWidth / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Toggle between grid view and list view,
                  Visibility(
                    visible: BlocProvider.of<FoldersCubit>(context)
                        .isSelectionOpened,
                    child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: IconButton(
                        onPressed: _showDeleteConfirmationDialog,
                        icon: const Icon(Icons.delete_sweep_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Crab(
                    tag: 'addButton',
                    child: CustomCircularButton(
                      onTapFunction: () => showAddFolderBottomSheet(context),
                      title: 'Add New Folder',
                      isButtonVisible: _isButtonVisible,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  // Toggle between grid view and list view
                  Visibility(
                    visible: _isButtonVisible,
                    child: CircleAvatar(
                      radius: 30,
                      child: FoldersViewModeToggle(
                        onViewModeChanged: (isGridView) {
                          setState(() {
                            _isGridView = isGridView;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFolderItem(FolderModel folder) {
    bool isSelectionOpened =
        BlocProvider.of<FoldersCubit>(context).isSelectionOpened;
    bool isSelected =
        BlocProvider.of<FoldersCubit>(context).selectedFolders.contains(folder);
    // List<FolderModel> selectedFolders =
    if (_isGridView) {
      // Render big folder item in grid view
      return GestureDetector(
        onTap: isSelectionOpened
            ? () {
                BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
              }
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FolderNotesView(
                        folder: folder,
                      ),
                    ));
              },
        onLongPress: () {
          BlocProvider.of<FoldersCubit>(context).isSelectionOpened = true;
          BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
        },
        child: Card(
          color: isSelected
              ? Colors.orangeAccent.withOpacity(0.4)
              : const Color(0xff28252c),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconData(folder.iconCode!, fontFamily: 'MaterialIcons'),
                    size: 36.0),
                const SizedBox(height: 8.0),
                Text(
                  folder.name!,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Theme.of(context).textTheme.titleLarge?.color),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // Render small widget in list view
      // Render small widget in list view
      return GestureDetector(
        onTap: isSelectionOpened
            ? () {
                BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
              }
            : () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FolderNotesView(
                        folder: folder,
                      ),
                    ));
              },
        onLongPress: () {
          BlocProvider.of<FoldersCubit>(context).isSelectionOpened = true;
          BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
        },
        child: Card(
          color: isSelected
              ? Colors.orangeAccent.withOpacity(0.4)
              : const Color(0xff28252c),
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: ListTile(
            leading: Icon(
                IconData(folder.iconCode!, fontFamily: 'MaterialIcons'),
                size: 36.0),
            title: Text(
              folder.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
          ),
        ),
      );
    }
  }

  void showAddFolderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return AddFolderBottomSheet(
          onAddFolder: (String folderName, IconData icon) {
            // setState(() {
            // folders.add({"folderName": folderName, "icon": icon});
            // });
            Navigator.pop(
                context); // Close the bottom sheet after adding folder
          },
        );
      },
    );
  }
}

class FoldersViewModeToggle extends StatefulWidget {
  final ValueChanged<bool> onViewModeChanged;

  const FoldersViewModeToggle({Key? key, required this.onViewModeChanged})
      : super(key: key);

  @override
  _FoldersViewModeToggleState createState() => _FoldersViewModeToggleState();
}

class _FoldersViewModeToggleState extends State<FoldersViewModeToggle> {
  bool _isGridView = true; // Initial state, grid view is enabled

  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
      widget.onViewModeChanged(_isGridView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleViewMode,
      icon: Icon(_isGridView ? Icons.view_module : Icons.view_list),
    );
  }
}
