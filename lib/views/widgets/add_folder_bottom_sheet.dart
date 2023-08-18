import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:idea/cubits/add_folder_cubit/add_folder_cubit.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';

class AddFolderBottomSheet extends StatefulWidget {
  final void Function(String folderName, IconData icon) onAddFolder;

  const AddFolderBottomSheet({Key? key, required this.onAddFolder})
      : super(key: key);

  @override
  _AddFolderBottomSheetState createState() => _AddFolderBottomSheetState();
}

class _AddFolderBottomSheetState extends State<AddFolderBottomSheet> {
  void _submitForm() {
    var folderModel = FolderModel(
        name: _folderNameController.text, iconCode: _selectedIcon.codePoint);
    BlocProvider.of<AddFolderCubit>(context).addFolder(folderModel);
    BlocProvider.of<FoldersCubit>(context).fetchAllFolders();
    Navigator.pop(context);
  }

  final TextEditingController _folderNameController = TextEditingController();
  IconData _selectedIcon = Icons.folder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddFolderCubit(),
      child: BlocConsumer<AddFolderCubit, AddFolderState>(
        listener: (context, state) {
          if (state is AddFolderFailure) {
            if (kDebugMode) {
              print('Failed ${state.errMessage}');
            }
          }

          if (state is AddFolderSuccess) {
            BlocProvider.of<FoldersCubit>(context).fetchAllFolders();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: state is AddFolderLoading ? true : false,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        _selectedIcon,
                        size: 36.0,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          _pickIcon(); // Show the icon picker dialog
                        },
                        child: const Text('Choose Icon'),
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: _folderNameController,
                        decoration:
                            const InputDecoration(labelText: 'Folder Name'),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Add Folder'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      // iconPackMode:
      //     IconPack.cupertino, // You can change the icon pack as needed
      title: const Text('Select Folder Icon'),
    );

    if (icon != null) {
      setState(() {
        _selectedIcon = icon;
      });
    }
  }
}
