import 'package:hive/hive.dart';
import 'package:idea/models/note_model.dart';

part 'folder_model.g.dart';

@HiveType(typeId: 1)
class FolderModel extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? iconCode;
  @HiveField(2)
  List<NoteModel>? folderNotes;

  FolderModel({
    required this.name,
    required this.iconCode,
  });
}
