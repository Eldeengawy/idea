import 'package:flutter/material.dart';
import 'package:idea/app_constants.dart';
import 'package:idea/views/widgets/custom_mode_switch_button.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  void toggleTheme() {
    setState(() {
      isNightMode = !isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'IDEA',
          style: TextStyle(color: Colors.white, fontSize: 28.0),
        ),
        CustomModeSwitchButton(
          isNightMode: isNightMode,
          onTap: toggleTheme,
        ),
      ],
    );
  }
}
