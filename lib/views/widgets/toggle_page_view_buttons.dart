import 'package:flutter/material.dart';

class TogglePageViewButtons extends StatefulWidget {
  const TogglePageViewButtons({Key? key}) : super(key: key);

  @override
  _TogglePageViewButtonsState createState() => _TogglePageViewButtonsState();
}

class _TogglePageViewButtonsState extends State<TogglePageViewButtons> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildButton(0, 'All Notes'),
        _buildButton(1, 'Folders'),
      ],
    );
  }

  Widget _buildButton(int index, String text) {
    final isSelected = selectedIndex == index;
    return InkWell(
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xffff9e37) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.grey[600],
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
