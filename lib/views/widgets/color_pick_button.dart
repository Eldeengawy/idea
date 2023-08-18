import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerButton extends StatelessWidget {
  final Color selectedColor;
  // final VoidCallback onPressed;
  final BuildContext context;

  const ColorPickerButton({
    Key? key,
    required this.selectedColor,
    // required this.onPressed,
    required this.context,
  }) : super(key: key);

  void showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: (color) {
                // setState(() {
                //   selectedColor = color;
                // });
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
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30.0,
      backgroundColor: Colors.blueGrey,
      child: IconButton(
        onPressed: showColorPicker,
        icon: const Icon(Icons.color_lens),
      ),
    );
  }
}
