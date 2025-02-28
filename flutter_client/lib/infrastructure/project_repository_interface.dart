import 'package:knitting/models/entities/project.dart';

abstract class ProjectRepositoryInterface {
  ProjectRepositoryInterface();

  Future<Project> fetchProject(String projectId);
  Future<List<Project>> fetchAllProjects();
}
