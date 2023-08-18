import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onTap, this.isLoading = false});
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              backgroundColor: const Color(0xffff9e37),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
            ),
            onPressed: onTap,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 24),
                SizedBox(width: 8),
                Text(
                  'Add Note',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        : const Center(
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                // strokeWidth: 6.0,

                color: Colors.amber,
              ),
            ),
          );
  }
}
