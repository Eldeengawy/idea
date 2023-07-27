import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class CustomModeSwitchButton extends StatelessWidget {
  final bool isNightMode;
  final VoidCallback onTap;

  const CustomModeSwitchButton({
    Key? key,
    required this.isNightMode,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          color: isNightMode
              ? Colors.blueGrey.withOpacity(0.6)
              : Colors.yellow.withOpacity(0.7),
        ),
        child: Center(
          child: Icon(
            isNightMode ? FeatherIcons.moon : FeatherIcons.sun,
            color: Theme.of(context).textTheme.titleLarge?.color,
            size: 20,
          ),
        ),
      ),
    );
  }
}
