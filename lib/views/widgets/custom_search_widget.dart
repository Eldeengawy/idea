import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff1d1b1e),
      ),
      child: Row(
        children: [
          const Icon(
            FeatherIcons.search,
            color: Colors.white,
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
            backgroundImage: AssetImage('assets/user_image.jpg'),
            radius: 20,
          ),
        ],
      ),
    );
  }
}
