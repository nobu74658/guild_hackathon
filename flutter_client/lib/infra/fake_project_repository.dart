import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';

class FakeProjectRepository extends ProjectRepositoryInterface {
  FakeProjectRepository() {
    debugPrint('FakeProjectRepository instance created');
  }

  @override
  Future<Project> fetchProject(String projectId) async {
    return Future.value(
      Project(
        projectId: '1',
        title: 'Project Title',
        colors: [],
        imageUrl: '',
      ),
    );
  }

  @override
  Future<List<Project>> fetchAllProjects() async {
    return Future.value(
      [
        Project(
          projectId: '1',
          title: 'Project Title',
          colors: [],
          imageUrl: '',
        ),
      ],
    );
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
}
