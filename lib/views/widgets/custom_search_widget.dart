import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:idea/constants/app_images.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Theme.of(context).textTheme.titleLarge?.color == Colors.white
            ? Border.all(color: Colors.transparent)
            : Border.all(),
        color: Theme.of(context).textTheme.titleLarge?.color == Colors.white
            ? const Color(0xff1d1b1e)
            : Colors.white,
      ),
      child: Row(
        children: [
          Icon(
            FeatherIcons.search,
            color: Theme.of(context).textTheme.titleLarge?.color,
            size: 24,
          ),
          const SizedBox(width: 8),
          Expanded(
            // This will make the search field take all available space
            child: TextField(
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
              decoration: InputDecoration(
                hintText: 'Search your notes',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                // Implement your search logic here
                // For example, you can store the search query in a variable or use it to filter your notes.
                print("Search query: $value");
              },
            ),
          ),
          const CircleAvatar(
            backgroundImage: AssetImage(Assets.imagesProfilePic1),
            radius: 20,
          ),
        ],
      ),
    );
  }
}
