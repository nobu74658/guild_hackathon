import 'package:isar/isar.dart';

part 'project.g.dart';

@collection
class IsaProject {
  Id id = Isar.autoIncrement;

  String? title;
  String? imagePath;
}

class Project {
  Project({
    required this.projectId,
    required this.title,
    required this.imagePath,
  });
  final int projectId;
  final String title;
  final String imagePath;

  static Project? fromIsar(IsaProject isar) {
    return Project(
      projectId: isar.id,
      title: isar.title!,
      imagePath: isar.imagePath!,
    );
  }

  IsaProject toIsar() {
    return IsaProject()
      ..id = projectId
      ..title = title
      ..imagePath = imagePath;
  }
}
