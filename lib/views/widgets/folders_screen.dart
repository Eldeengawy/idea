import 'package:flutter/material.dart';
import 'package:idea/views/widgets/add_folder_bottom_sheet.dart';
import 'package:idea/views/widgets/custom_circular_button.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({Key? key}) : super(key: key);

  @override
  _FoldersScreenState createState() => _FoldersScreenState();
}

class _FoldersScreenState extends State<FoldersScreen> {
  List<Map<String, dynamic>> folders = [
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Important folder", "icon": Icons.folder},
    {"folderName": "Education", "icon": Icons.design_services},
    {"folderName": "labels", "icon": Icons.label},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.9,
            ),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              return _buildFolderItem(folders[index]);
            },
          ),
        ),
        CustomCircularButton(
          onTapFunction: () => showAddFolderBottomSheet(context),
          title: 'Add New Folder',
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildFolderItem(Map<String, dynamic> folder) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(folder['icon'], size: 36.0),
            const SizedBox(height: 8.0),
            Text(
              folder['folderName'],
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void showAddFolderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AddFolderBottomSheet(
          onAddFolder: (String folderName, IconData icon) {
            setState(() {
              folders.add({"folderName": folderName, "icon": icon});
            });
            Navigator.pop(
                context); // Close the bottom sheet after adding folder
          },
        );
      },
    );
  }
}
