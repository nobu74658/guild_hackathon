import 'package:image/image.dart' as img;
import 'package:knitting/model/entities/project.dart';

abstract class ProjectRepositoryInterface {
  ProjectRepositoryInterface();

  Future<Project> fetchProject(String projectId);
  Future<List<Project>> fetchAllProjects();
  Future<img.Image> generateDottedImage(img.Image image, int width, int height, List<String> colors);
}
