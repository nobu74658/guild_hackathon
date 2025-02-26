abstract class ProjectRepositoryInterface {
  ProjectRepositoryInterface();

  Future<void> fetchProject(String projectId);
  Future<void> fetchAllProjects();
}
