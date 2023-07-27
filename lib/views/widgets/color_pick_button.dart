import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  final Color selectedColor;
  final VoidCallback onPressed;

  const ColorPickerButton({
    Key? key,
    required this.selectedColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundColor: Colors.blueGrey,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.color_lens),
      ),
    );
  }
}
