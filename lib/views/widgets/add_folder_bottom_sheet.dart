import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';


class AddFolderBottomSheet extends StatefulWidget {
  final void Function(String folderName, IconData icon) onAddFolder;

  const AddFolderBottomSheet({Key? key, required this.onAddFolder})
      : super(key: key);

  @override
  _AddFolderBottomSheetState createState() => _AddFolderBottomSheetState();
}


class _AddFolderBottomSheetState extends State<AddFolderBottomSheet> {
  final TextEditingController _folderNameController = TextEditingController();
  IconData _selectedIcon = Icons.folder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
            decoration: const InputDecoration(labelText: 'Folder Name'),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              String folderName = _folderNameController.text;
              widget.onAddFolder(folderName, _selectedIcon);
            },
            child: const Text('Add Folder'),
          ),
        ],
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
