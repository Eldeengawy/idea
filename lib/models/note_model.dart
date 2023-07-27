import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? content;
  @HiveField(2)
  final int? color;
  @HiveField(3)
  final String? date;
  @HiveField(4)
  final String? folderName;

  NoteModel({
    required this.date,
    required this.title,
    required this.content,
    this.color,
    this.folderName,
  });
}
