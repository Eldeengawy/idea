import 'package:flutter/material.dart';

class Note {
  final String? title;
  final String? content;
  final Color? color;
  final String? date;
  final String? folderName;

  Note({
    this.date,
    required this.title,
    required this.content,
    this.color,
    this.folderName,
  });
}
