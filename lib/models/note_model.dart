import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? content;
  @HiveField(2)
  final Color? color;
  @HiveField(3)
  final String? date;
  @HiveField(4)
  final String? folderName;

  Note({
    this.date,
    required this.title,
    required this.content,
    this.color,
    this.folderName,
  });
}
