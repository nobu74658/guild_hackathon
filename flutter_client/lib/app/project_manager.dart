import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infrastructure/project_repository.dart';
import 'package:knitting/infrastructure/project_repository_interface.dart';
import 'package:knitting/models/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_manager.g.dart';

abstract class ProjectManagerInterface {
  Future<Project> fetchProject(String projectId);
  Future<List<Project>> fetchAllProjects();
}

@riverpod
ProjectManagerInterface projectManager(Ref ref) =>
    _ProjectManager(repository: ref.read(projectRepositoryProvider));

class _ProjectManager extends ProjectManagerInterface {
  _ProjectManager({required this.repository});

  final ProjectRepositoryInterface repository;

  @override
  Future<Project> fetchProject(String projectId) async {
    return repository.fetchProject(projectId);
  }

  @override
  Future<List<Project>> fetchAllProjects() async {
    return repository.fetchAllProjects();
  }
}
