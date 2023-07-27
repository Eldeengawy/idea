import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  List<Map<String, dynamic>> folders = [
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Alarms", "icon": Icons.access_alarm_rounded},
    {"folderName": "Important folder", "icon": Icons.folder},
    {"folderName": "Education", "icon": Icons.design_services},
    {"folderName": "labels", "icon": Icons.label},
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        GridView.builder(
          controller: _scrollController,
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
        Positioned(
          bottom: 20.0,
          left: screenWidth / 6,
          child: Crab(
            tag: 'addButton',
            child: CustomCircularButton(
              onTapFunction: () => showAddFolderBottomSheet(context),
              title: 'Add New Folder',
              isButtonVisible: _isButtonVisible,
            ),
          ),
        ),
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
              style: TextStyle(
                  fontSize: 16.0,
                  color: Theme.of(context).textTheme.titleLarge?.color),
            ),
          ],
        ),
      ),
    );
  }

  void showAddFolderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
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
