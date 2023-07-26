import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddNoteBottomSheet extends StatefulWidget {
  final void Function(
      String title, String content, Color color, String folderName) onAddFolder;

  const AddNoteBottomSheet({Key? key, required this.onAddFolder})
      : super(key: key);

  @override
  _AddNoteBottomSheetState createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final String _selectedFolderName = '';
  Color _selectedColor = const Color(0xff17181a); // Default color

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // You can also handle the color picking here if needed
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(labelText: 'Subject'),
            ),
            const SizedBox(height: 12),
            // ColorPicker(
            // onColorChanged: (color) {
            // Implement color picker logic here

            const SizedBox(height: 12),
            // _buildFolderDropdown(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      backgroundColor: const Color(0xffff9e37),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () {
                      String title = _titleController.text;
                      String subject = _subjectController.text;
                      Color color = _selectedColor;
                      String folderName = _selectedFolderName;
                      widget.onAddFolder(title, subject, color, folderName);
                      Navigator.pop(context);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Add Note',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.blueGrey,
                  child: IconButton(
                    onPressed: () {
                      _showColorPicker();
                    },
                    icon: const Icon(Icons.color_lens),

                    // },
                    // pickerColor: _selectedColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFolderDropdown() {
    // Implement folder dropdown logic here
    // You can use DropdownButtonFormField to select from existing folders
    // Or create a separate bottom sheet to create a new folder
    return Container();
  }
}
