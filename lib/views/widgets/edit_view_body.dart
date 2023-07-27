import 'package:flutter/material.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/custom_save_button.dart';

class EditNoteViewBody extends StatefulWidget {
  final NoteModel? note; // Note object to be edited, nullable

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
      _titleController.text = widget.note!.title!;
      _contentController.text = widget.note!.content!;
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
                    // color: Colors.white,
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
            const CustomSaveButton(),
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
              fontSize: 26,
              //  color: Colors.white,
              fontWeight: FontWeight.bold)
          : Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                // color: Colors.white,
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
