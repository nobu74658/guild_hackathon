import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/build/grpc/projects.pbgrpc.dart' as grpc_projects;
import 'package:knitting/infra/grpc_repository.dart';
import 'package:knitting/infra/project_repository_interface.dart';
import 'package:knitting/model/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_repository.g.dart';

@Riverpod(keepAlive: true)
ProjectRepositoryInterface projectRepository(Ref ref) =>
    _ProjectRepository(channel: ref.watch(clientChannelProvider));

class _ProjectRepository extends ProjectRepositoryInterface {
  _ProjectRepository({required this.channel}) {
    debugPrint('ProjectRepository instance created');
  }

  final ClientChannel channel;

  @override
  Future<Project> fetchProject(String projectId) async {
    final client = grpc_projects.ProjectServiceClient(channel);
    final userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final request = grpc_projects.GetProjectRequest(id: projectId);
    final response = await client.getProject(
      request,
      options: CallOptions(
        metadata: {
          'Authorization': 'Bearer ${userIdToken ?? ''}',
        },
      ),
    );
    return Project(
      projectId: response.id,
      title: response.title,
      imageUrl: '',
      colors: List.empty(),
    );
  }

  @override
  Future<List<Project>> fetchAllProjects() async {
    final client = grpc_projects.ProjectServiceClient(channel);
    final userIdToken = await FirebaseAuth.instance.currentUser?.getIdToken();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User is not authenticated');
    }
    final request = grpc_projects.GetProjectsRequest(userId: currentUser.uid);
    final response = await client.getProjects(
      request,
      options: CallOptions(
        metadata: {
          'Authorization': 'Bearer ${userIdToken ?? ''}',
        },
      ),
    );
    return response.projects
        .map(
          (project) => Project(
            projectId: project.id,
            title: project.title,
            imageUrl: '',
            colors: List.empty(),
          ),
        )
        .toList();
  }

  @override
  Future<img.Image> generateDottedImage(
    img.Image image,
    int width,
    int height,
    List<String> colors,
  ) async {
    final client = grpc_projects.ProjectServiceClient(channel);

    // ストリーミングリクエストを作成
    final requestStream =
        StreamController<grpc_projects.GenerateDottedImageRequest>();

    // まず Meta 情報を送信
    requestStream.add(
      grpc_projects.GenerateDottedImageRequest(
        meta: grpc_projects.Meta(
          width: Int64(width),
          height: Int64(height),
          colors: colors,
        ),
      ),
    );

    // 次に画像データを送信
    requestStream.add(
      grpc_projects.GenerateDottedImageRequest(
        image: img.encodePng(image).toList(),
      ),
    );

    // ストリームを閉じる
    requestStream.close();

    // レスポンスを待機
    final response = await client.generateDottedImage(requestStream.stream);

    // 返却された画像データを Image オブジェクトに変換
    // バイトデータから PNG 画像としてデコードする
    final dottedImage = img.decodePng(Uint8List.fromList(response.image));
    if (dottedImage == null) {
      throw Exception('Failed to decode the received image');
    }

    return dottedImage;
  }
}
