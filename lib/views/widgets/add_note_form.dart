import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idea/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:idea/cubits/folders_cubit/folders_cubit_cubit.dart';
import 'package:idea/models/folder_model.dart';
import 'package:idea/models/note_model.dart';
import 'package:idea/views/widgets/add_note_to_folder_form.dart';
import 'package:idea/views/widgets/color_pick_button.dart';
import 'package:intl/intl.dart'; // Import the intl package

class AddNoteForm extends StatefulWidget {
  // final void Function(
  //     String title, String content, Color color, String folderName) onAddFolder;

  const AddNoteForm({
    Key? key,
  }) : super(key: key);

  @override
  _AddNoteFormState createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final Color _selectedColor = const Color(0xff17181a); // Default color
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

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
      // String folderName = ''; // Replace with actual folder name logic
      // widget.onAddFolder(title, content, _selectedColor, folderName);
      // Navigator.pop(context);
      // Format the date in your desired format
      DateTime now = DateTime.now();

      String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(now);
      var noteModel = NoteModel(
          title: title,
          content: content,
          date: formattedDate,
          folderName: selectedFolder);
      BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
      // BlocProvider.of<FoldersCubit>(context).addNoteToFolder(noteModel,folder);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  // String selectedFolder = 'Folder 1'; // To store the selected folder name
  List<FolderModel> folders = [];
  String selectedFolder = '';

  @override
  Widget build(BuildContext context) {
    folders = BlocProvider.of<FoldersCubit>(context).folders!;
    selectedFolder =
        folders.isNotEmpty ? folders[0].name! : 'No folders available';
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
                // Dropdown button to choose a folder
                // Dropdown button to choose a folder
                DropdownButtonFormField<String>(
                  value: selectedFolder,
                  items: folders.map((FolderModel folder) {
                    return DropdownMenuItem<String>(
                      value: folder.name,
                      child: Text(
                        folder.name!,
                        style:
                            Theme.of(context).textTheme.bodySmall!.copyWith(),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFolder = newValue!;
                      BlocProvider.of<AddNoteCubit>(context).selectedfolder =
                          newValue;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Select Folder',
                    labelStyle:
                        Theme.of(context).textTheme.titleLarge!.copyWith(
                            // Set the label (hint) text color to white
                            ),
                    // You can also customize other decoration properties if needed
                    // For example, you can set fillColor, filled, border, etc.
                  ),
                  style: const TextStyle(
                    color: Colors
                        .white, // Set the selected item text color to white
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a folder';
                    }
                    return null;
                  },
                ),

                const SizedBox(
                  height: 20,
                ),
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
                      selectedColor: _selectedColor, context: context,
                      // onPressed: () => showColorPicker(),
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
