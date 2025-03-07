import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';

class FakeProjectRepository extends ProjectRepositoryInterface {
  FakeProjectRepository() {
    debugPrint('FakeProjectRepository instance created');
  }

  @override
  Future<Project> fetchProject(int projectId) async {
    return Future.value(
      Project(
        projectId: 1,
        title: 'Project Title',
        imagePath: '',
      ),
    );
  }

  @override
  Stream<List<Project>> stream() async* {
    yield [
      Project(
        projectId: 1,
        title: 'Project Title',
        imagePath: '',
      ),
    ];
  }

  @override
  Future<img.Image> generateDottedImage(
    img.Image image,
    int width,
    int height,
    List<String> colors,
  ) {
    final resizedImage = img.copyResize(
      image,
      width: width,
      height: height,
    );
    return Future.value(resizedImage);
  }

  @override
  Future<void> saveProject(img.Image image) {
    return Future.value();
  }

  @override
  Future<void> updateProject(img.Image image, int projectId, String imageUrl) {
    return Future.value();
  }

  @override
  Future<void> deleteProject(int projectId) {
    return Future.value();
  }
}
