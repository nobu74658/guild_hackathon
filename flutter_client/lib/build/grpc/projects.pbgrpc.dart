//
//  Generated code. Do not modify.
//  source: projects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'projects.pb.dart' as $0;

export 'projects.pb.dart';

@$pb.GrpcServiceName('api.ProjectService')
class ProjectServiceClient extends $grpc.Client {
  static final _$getProjects = $grpc.ClientMethod<$0.GetProjectsRequest, $0.GetProjectsResponse>(
      '/api.ProjectService/GetProjects',
      ($0.GetProjectsRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetProjectsResponse.fromBuffer(value));
  static final _$generateDottedImage = $grpc.ClientMethod<$0.GenerateDottedImageRequest, $0.GenerateDottedImageResponse>(
      '/api.ProjectService/GenerateDottedImage',
      ($0.GenerateDottedImageRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GenerateDottedImageResponse.fromBuffer(value));
  static final _$createProject = $grpc.ClientMethod<$0.CreateProjectRequest, $0.Project>(
      '/api.ProjectService/CreateProject',
      ($0.CreateProjectRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Project.fromBuffer(value));
  static final _$getProject = $grpc.ClientMethod<$0.GetProjectRequest, $0.Project>(
      '/api.ProjectService/GetProject',
      ($0.GetProjectRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Project.fromBuffer(value));
  static final _$updateProject = $grpc.ClientMethod<$0.UpdateProjectRequest, $0.Project>(
      '/api.ProjectService/UpdateProject',
      ($0.UpdateProjectRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Project.fromBuffer(value));

  ProjectServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.GetProjectsResponse> getProjects($0.GetProjectsRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProjects, request, options: options);
  }

  $grpc.ResponseFuture<$0.GenerateDottedImageResponse> generateDottedImage($async.Stream<$0.GenerateDottedImageRequest> request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$generateDottedImage, request, options: options).single;
  }

  $grpc.ResponseFuture<$0.Project> createProject($0.CreateProjectRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.Project> getProject($0.GetProjectRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProject, request, options: options);
  }

  $grpc.ResponseFuture<$0.Project> updateProject($0.UpdateProjectRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateProject, request, options: options);
  }
}

@$pb.GrpcServiceName('api.ProjectService')
abstract class ProjectServiceBase extends $grpc.Service {
  $core.String get $name => 'api.ProjectService';

  ProjectServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetProjectsRequest, $0.GetProjectsResponse>(
        'GetProjects',
        getProjects_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProjectsRequest.fromBuffer(value),
        ($0.GetProjectsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GenerateDottedImageRequest, $0.GenerateDottedImageResponse>(
        'GenerateDottedImage',
        generateDottedImage,
        true,
        false,
        ($core.List<$core.int> value) => $0.GenerateDottedImageRequest.fromBuffer(value),
        ($0.GenerateDottedImageResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.CreateProjectRequest, $0.Project>(
        'CreateProject',
        createProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.CreateProjectRequest.fromBuffer(value),
        ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProjectRequest, $0.Project>(
        'GetProject',
        getProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProjectRequest.fromBuffer(value),
        ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateProjectRequest, $0.Project>(
        'UpdateProject',
        updateProject_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.UpdateProjectRequest.fromBuffer(value),
        ($0.Project value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetProjectsResponse> getProjects_Pre($grpc.ServiceCall call, $async.Future<$0.GetProjectsRequest> request) async {
    return getProjects(call, await request);
  }

  $async.Future<$0.Project> createProject_Pre($grpc.ServiceCall call, $async.Future<$0.CreateProjectRequest> request) async {
    return createProject(call, await request);
  }

  $async.Future<$0.Project> getProject_Pre($grpc.ServiceCall call, $async.Future<$0.GetProjectRequest> request) async {
    return getProject(call, await request);
  }

  $async.Future<$0.Project> updateProject_Pre($grpc.ServiceCall call, $async.Future<$0.UpdateProjectRequest> request) async {
    return updateProject(call, await request);
  }

  $async.Future<$0.GetProjectsResponse> getProjects($grpc.ServiceCall call, $0.GetProjectsRequest request);
  $async.Future<$0.GenerateDottedImageResponse> generateDottedImage($grpc.ServiceCall call, $async.Stream<$0.GenerateDottedImageRequest> request);
  $async.Future<$0.Project> createProject($grpc.ServiceCall call, $0.CreateProjectRequest request);
  $async.Future<$0.Project> getProject($grpc.ServiceCall call, $0.GetProjectRequest request);
  $async.Future<$0.Project> updateProject($grpc.ServiceCall call, $0.UpdateProjectRequest request);
}
