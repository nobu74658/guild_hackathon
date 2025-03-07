import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:knitting/infra/project_fast_api_repository.dart';
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_manager.g.dart';

abstract class ProjectManagerInterface {
  Future<Project> fetchProject(int projectId);
  Stream<List<Project>> stream();
  Future<Image> generateDottedImage(
    Image image,
    int width,
    int height,
    List<String> colors,
  );
  Future<void> saveProject({required img.Image image});
  Future<void> updateProject({
    required img.Image image,
    required int projectId,
    required String imageUrl,
  });
  Future<void> deleteProject({required int projectId});
}

@riverpod
ProjectManagerInterface projectManager(Ref ref) =>
    _ProjectManager(repository: ref.read(projectFastApiRepositoryProvider));

class _ProjectManager extends ProjectManagerInterface {
  _ProjectManager({required this.repository});

  final ProjectRepositoryInterface repository;

  @override
  Future<Project> fetchProject(int projectId) async {
    return repository.fetchProject(projectId);
  }

  @override
  Stream<List<Project>> stream() {
    return repository.stream();
  }

  @override
  Future<Image> generateDottedImage(
    Image image,
    int width,
    int height,
    List<String> colors,
  ) {
    return repository.generateDottedImage(image, width, height, colors);
  }

  @override
  Future<void> saveProject({required img.Image image}) {
    return repository.saveProject(image);
  }

  @override
  Future<void> updateProject({
    required img.Image image,
    required int projectId,
    required String imageUrl,
  }) {
    return repository.updateProject(image, projectId, imageUrl);
  }

  @override
  Future<void> deleteProject({required int projectId}) {
    return repository.deleteProject(projectId);
  }
}
