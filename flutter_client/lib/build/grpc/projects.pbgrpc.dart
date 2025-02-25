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
  static final _$getProjectByProjectId = $grpc.ClientMethod<$0.GetProjectByProjectIdRequest, $0.Project>(
      '/api.ProjectService/GetProjectByProjectId',
      ($0.GetProjectByProjectIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Project.fromBuffer(value));
  static final _$getProjectsByUserId = $grpc.ClientMethod<$0.GetProjectsByUserIdRequest, $0.GetProjectsByUserIdResponse>(
      '/api.ProjectService/GetProjectsByUserId',
      ($0.GetProjectsByUserIdRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.GetProjectsByUserIdResponse.fromBuffer(value));

  ProjectServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.Project> getProjectByProjectId($0.GetProjectByProjectIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProjectByProjectId, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetProjectsByUserIdResponse> getProjectsByUserId($0.GetProjectsByUserIdRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getProjectsByUserId, request, options: options);
  }
}

@$pb.GrpcServiceName('api.ProjectService')
abstract class ProjectServiceBase extends $grpc.Service {
  $core.String get $name => 'api.ProjectService';

  ProjectServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetProjectByProjectIdRequest, $0.Project>(
        'GetProjectByProjectId',
        getProjectByProjectId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProjectByProjectIdRequest.fromBuffer(value),
        ($0.Project value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetProjectsByUserIdRequest, $0.GetProjectsByUserIdResponse>(
        'GetProjectsByUserId',
        getProjectsByUserId_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProjectsByUserIdRequest.fromBuffer(value),
        ($0.GetProjectsByUserIdResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.Project> getProjectByProjectId_Pre($grpc.ServiceCall call, $async.Future<$0.GetProjectByProjectIdRequest> request) async {
    return getProjectByProjectId(call, await request);
  }

  $async.Future<$0.GetProjectsByUserIdResponse> getProjectsByUserId_Pre($grpc.ServiceCall call, $async.Future<$0.GetProjectsByUserIdRequest> request) async {
    return getProjectsByUserId(call, await request);
  }

  $async.Future<$0.Project> getProjectByProjectId($grpc.ServiceCall call, $0.GetProjectByProjectIdRequest request);
  $async.Future<$0.GetProjectsByUserIdResponse> getProjectsByUserId($grpc.ServiceCall call, $0.GetProjectsByUserIdRequest request);
}
