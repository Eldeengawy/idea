import 'package:flutter/material.dart';

class Note {
  String title;
  String content;
  Color? color;
  String? folderName;

  Note({
    required this.title,
    required this.content,
    this.color,
    this.folderName,
  });
}
