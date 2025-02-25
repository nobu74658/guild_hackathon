//
//  Generated code. Do not modify.
//  source: users.proto
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

import 'users.pb.dart' as $1;

export 'users.pb.dart';

@$pb.GrpcServiceName('api.UserService')
class UserServiceClient extends $grpc.Client {
  static final _$getUser = $grpc.ClientMethod<$1.UserRequest, $1.User>(
      '/api.UserService/GetUser',
      ($1.UserRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.User.fromBuffer(value));

  UserServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$1.User> getUser($1.UserRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getUser, request, options: options);
  }
}

@$pb.GrpcServiceName('api.UserService')
abstract class UserServiceBase extends $grpc.Service {
  $core.String get $name => 'api.UserService';

  UserServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.UserRequest, $1.User>(
        'GetUser',
        getUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.UserRequest.fromBuffer(value),
        ($1.User value) => value.writeToBuffer()));
  }

  $async.Future<$1.User> getUser_Pre($grpc.ServiceCall call, $async.Future<$1.UserRequest> request) async {
    return getUser(call, await request);
  }

  $async.Future<$1.User> getUser($grpc.ServiceCall call, $1.UserRequest request);
}
