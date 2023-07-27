import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  const CustomCircularButton(
      {super.key,
      required this.onTapFunction,
      required this.title,
      required this.isButtonVisible});
  final void Function()? onTapFunction;
  final String? title;
  final bool isButtonVisible;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: onTapFunction,
      child: AnimatedContainer(
        height: isButtonVisible ? 70 : 0,
        width: isButtonVisible ? 250 : 125,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xfffd9f4f), Color(0xffff9d34)],
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.all(16.0),
        // height: 70.0,
        // width: 250.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: isButtonVisible ? 22.0 : 0),
            const SizedBox(width: 8.0),
            Text(
              '$title',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: isButtonVisible ? 16.0 : 0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
