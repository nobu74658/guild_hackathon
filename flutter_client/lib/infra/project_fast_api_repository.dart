import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:isar/isar.dart';
import 'package:knitting/common/providers.dart';
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'project_fast_api_repository.g.dart';

@Riverpod(keepAlive: true)
ProjectRepositoryInterface projectFastApiRepository(Ref ref) =>
    ProjectFastApiRepository(
      ref.read(getIsarProvider.future),
      ref.read(getSharedPreferencesProvider.future),
      ref.read(getDirProvider.future),
    );

class ProjectFastApiRepository extends ProjectRepositoryInterface {
  ProjectFastApiRepository(this._isar, this._sharedPreferences, this._dir);

  final Future<Isar> _isar;
  // ignore: unused_field
  final Future<SharedPreferences> _sharedPreferences;
  final Future<Directory> _dir;

  @override
  Future<Project> fetchProject(int projectId) async {
    final isar = await _isar;
    final isaProject =
        isar.isaProjects.where().filter().idEqualTo(projectId).findFirstSync();
    if (isaProject == null) {
      throw Exception('Project not found');
    }
    final project = Project.fromIsar(isaProject);
    if (project == null) {
      throw Exception('Failed to convert IsarProject to Project');
    }
    return project;
  }

  @override
  Stream<List<Project>> stream() async* {
    final isar = await _isar;
    final stream =
        isar.isaProjects.buildQuery<IsaProject>().watch(fireImmediately: true);
    yield* stream.map(
      (event) => event
          .map((e) => Project.fromIsar(e))
          .toList()
          .whereType<Project>()
          .toList(),
    );
  }

  @override
  Future<img.Image> generateDottedImage(
    img.Image image,
    int width,
    int height,
    List<String> colors,
  ) async {
    try {
      final colorHexes = colors
          .map(
            (color) => '&available_colors_hex=$color'.replaceFirst('#', '%23'),
          )
          .join();
      final url = Uri.parse(
        'https://knitting-image-server-jlgdobzt4q-an.a.run.app/api/convert?output_column=$width&output_row=$height&width_ratio=1&height_ratio=1&shear=0$colorHexes',
      );

      final encodedImage = Uint8List.fromList(img.encodePng(image));

      final request = http.MultipartRequest('POST', url)
        ..headers.addAll({
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
        })
        ..files.add(
          http.MultipartFile.fromBytes(
            'image_file',
            encodedImage,
            filename: 'image.png',
            contentType: MediaType.parse('image/png'),
          ),
        );

      final response = await request.send();
      if (response.statusCode != 200) {
        throw Exception(
          'Failed to connect to the server. Status code: ${response.statusCode}',
        );
      }
      final responseBytes = await response.stream.toBytes();

      final uint8List = Uint8List.fromList(responseBytes);

      final responseImage = img.decodePng(uint8List);
      if (responseImage == null) {
        throw Exception('Failed to decode the image');
      }
      return responseImage;
    } catch (e) {
      debugPrint('Failed to connect to the server. Error: $e');
      throw Exception('Failed to connect to the server. Error: $e');
    }
  }

  @override
  Future<void> saveProject(img.Image image) async {
    final dir = await _dir;
    final randomName = DateTime.now().millisecondsSinceEpoch;
    final file = File('${dir.path}/$randomName.png');
    final encodedImage = Uint8List.fromList(img.encodePng(image));
    await file.writeAsBytes(encodedImage);

    final isar = await _isar;
    final isaProject = IsaProject()
      ..title = 'New Project'
      ..imagePath = file.path;
    isar.writeTxn(() async {
      isar.isaProjects.put(isaProject);
    });
  }

  @override
  Future<void> updateProject(
    img.Image image,
    int projectId,
    String imageUrl,
  ) async {
    final file = File(imageUrl);
    final encodedImage = Uint8List.fromList(img.encodePng(image));
    await file.writeAsBytes(encodedImage);

    final isar = await _isar;
    final isaProject =
        isar.isaProjects.where().filter().idEqualTo(projectId).findFirstSync();
    if (isaProject == null) {
      throw Exception('Project not found');
    }
    isaProject.imagePath = file.path;
    isar.writeTxn(() async {
      isar.isaProjects.put(isaProject);
    });
  }

  @override
  Future<void> deleteProject(int projectId) async {
    final isar = await _isar;
    isar.writeTxn(() async {
      isar.isaProjects.delete(projectId);
    });
  }
}
