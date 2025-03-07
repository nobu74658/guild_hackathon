import 'package:image/image.dart' as img;
import 'package:knitting/model/entities/project.dart';

abstract class ProjectRepositoryInterface {
  ProjectRepositoryInterface();

  Future<Project> fetchProject(int projectId);
  Stream<List<Project>> stream();
  Future<img.Image> generateDottedImage(
    img.Image image,
    int width,
    int height,
    List<String> colors,
  );
  Future<void> saveProject(img.Image image);
  Future<void> updateProject(img.Image image, int projectId, String imageUrl);
  Future<void> deleteProject(int projectId);
}
