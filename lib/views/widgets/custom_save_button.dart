import 'package:flutter/material.dart';

class CustomSaveButton extends StatelessWidget {
  const CustomSaveButton({
    super.key,
    required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        onPressed: onPressed,
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
    );
  }
}
