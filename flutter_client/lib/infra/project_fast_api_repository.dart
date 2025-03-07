import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';

class ProjectFastApiRepository extends ProjectRepositoryInterface {
  ProjectFastApiRepository();

  @override
  Future<Project> fetchProject(String projectId) {
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
  Future<List<Project>> fetchAllProjects() {
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
}
