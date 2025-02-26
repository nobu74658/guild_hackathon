import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infrastructure/project_repository.dart';
import 'package:knitting/infrastructure/project_repository_interface.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_manager.g.dart';

abstract class ProjectManagerInterface {
  Future<void> fetchProject(String projectId);
  Future<void> fetchAllProjects();
}

@riverpod
ProjectManagerInterface projectManager(Ref ref) =>
    _ProjectManager(repository: ref.read(projectRepositoryProvider));

class _ProjectManager extends ProjectManagerInterface {
  _ProjectManager({required this.repository});

  final ProjectRepositoryInterface repository;

  @override
  Future<void> fetchProject(String projectId) async {
    await repository.fetchProject(projectId);
  }

  @override
  Future<void> fetchAllProjects() async {
    await repository.fetchAllProjects();
  }
}
