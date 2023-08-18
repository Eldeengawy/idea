import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/views/folder_notes_view.dart';

enum FolderViewType {
  GridView,
  ListView,
}

class FolderItemWidget extends StatelessWidget {
  final BuildContext context;
  final FolderModel folder;
  final FolderViewType viewType;

  const FolderItemWidget(
      {super.key,
      required this.context,
      required this.folder,
      required this.viewType});

  @override
  Widget build(BuildContext context) {
    bool isSelectionOpened =
        BlocProvider.of<FoldersCubit>(context).isSelectionOpened;
    bool isSelected =
        BlocProvider.of<FoldersCubit>(context).selectedFolders.contains(folder);

    return GestureDetector(
      onTap: () {
        if (isSelectionOpened) {
          BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FolderNotesView(folder: folder),
            ),
          );
        }
      },
      onLongPress: () {
        BlocProvider.of<FoldersCubit>(context).isSelectionOpened = true;
        BlocProvider.of<FoldersCubit>(context).selectFolder(folder);
      },
      child: Card(
        color: isSelected
            ? Colors.orangeAccent.withOpacity(0.4)
            : Theme.of(context).textTheme.titleLarge?.color == Colors.white
                ? const Color(0xff28252c)
                : Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              viewType == FolderViewType.GridView ? 30.0 : 20.0),
        ),
        child: viewType == FolderViewType.GridView
            ? _buildGridViewContent()
            : _buildListViewContent(),
      ),
    );
  }

  Widget _buildGridViewContent() {
    return Center(
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
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListViewContent() {
    return ListTile(
      leading: Icon(IconData(folder.iconCode!, fontFamily: 'MaterialIcons'),
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
    );
  }
}
