import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:idea/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/color_pick_button.dart';
import 'package:intl/intl.dart'; // Import the intl package

class AddNoteForm extends StatefulWidget {
  final void Function(
      String title, String content, Color color, String folderName) onAddFolder;

  const AddNoteForm({Key? key, required this.onAddFolder}) : super(key: key);

  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  Color _selectedColor = const Color(0xff17181a); // Default color
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      String title = _titleController.text;
      String content = _subjectController.text;
      String folderName = ''; // Replace with actual folder name logic
      widget.onAddFolder(title, content, _selectedColor, folderName);
      // Navigator.pop(context);
      // Format the date in your desired format
      DateTime now = DateTime.now();

      String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(now);
      var noteModel =
          NoteModel(title: title, content: content, date: formattedDate);
      BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  onSaved: (value) {
                    // No need to store the value in class variables
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Field is required';
                    }
                    return null;
                  },
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  onSaved: (value) {
                    // No need to store the value in class variables
                  },
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Field is required';
                    }
                    return null;
                  },
                  controller: _subjectController,
                  decoration: const InputDecoration(labelText: 'Subject'),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: BlocBuilder<AddNoteCubit, AddNoteState>(
                      builder: (BuildContext context, AddNoteState state) =>
                          CustomButton(
                        isLoading: state is AddNoteLoading ? true : false,
                        onTap: _submitForm,
                      ),
                    )),
                    const SizedBox(
                      width: 20.0,
                    ),
                    ColorPickerButton(
                      selectedColor: _selectedColor,
                      onPressed: () => _showColorPicker(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.isLoading = false});
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              backgroundColor: const Color(0xffff9e37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            onPressed: onTap,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 24),
                SizedBox(width: 8),
                Text(
                  'Add Note',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : const Center(
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                // strokeWidth: 6.0,

                color: Colors.amber,
              ),
            ),
          );
  }
}
