import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:knitting/build/grpc/projects.pbgrpc.dart' as grpc_projects;
import 'package:knitting/common/infrastructure/grpc_repository.dart';
import 'package:knitting/infrastructure/project_repository_interface.dart';
import 'package:knitting/models/entities/project.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_repository.g.dart';

@Riverpod(keepAlive: true)
ProjectRepositoryInterface projectRepository(Ref ref) =>
    _ProjectRepository(channel: ref.watch(clientChannelProvider));

class _ProjectRepository extends ProjectRepositoryInterface {
  _ProjectRepository({required this.channel});

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
}
