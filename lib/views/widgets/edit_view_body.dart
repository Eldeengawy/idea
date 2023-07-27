import 'package:flutter/material.dart';
import 'package:idea/views/models/note_model.dart';

class EditNoteViewBody extends StatefulWidget {
  final Note? note; // Note object to be edited, nullable

  const EditNoteViewBody({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteViewBodyState createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Populate the text fields if a Note object is provided
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Text(
              'Edit Note',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildTextField(_titleController, 'Title'),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex:
                  6, // Adjust the flex value as needed to control the height ratio
              child: _buildTextField(_contentController, 'Note content',
                  maxLines: 10),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: 200, // Customize the width as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFfea031), // Starting gradient color
                    Color(0xFFee7905), // Starting gradient color
                    Color(0xFFee5453), // Starting gradient color
                    Color(0xFFfd5b6d), // Starting gradient color
                    Color(0xFFeb2774), // Starting gradient color
                    Color(0xFFd50382), // Starting gradient color
                    // Color(0xFF3366FF), // Starting gradient color
                    // Color(0xFF00CCFF), // Ending gradient color
                  ],
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Add your logic to save the note here
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0, // Set text color to white
                ),
                child: Text(
                  'Save Note',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      style: hintText == 'Title'
          ? Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold)
          : Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: Colors.white,
              ),
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
