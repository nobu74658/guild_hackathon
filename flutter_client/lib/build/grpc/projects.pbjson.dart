//
//  Generated code. Do not modify.
//  source: projects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use getProjectByProjectIdRequestDescriptor instead')
const GetProjectByProjectIdRequest$json = {
  '1': 'GetProjectByProjectIdRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetProjectByProjectIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectByProjectIdRequestDescriptor = $convert.base64Decode(
    'ChxHZXRQcm9qZWN0QnlQcm9qZWN0SWRSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use getProjectsByUserIdRequestDescriptor instead')
const GetProjectsByUserIdRequest$json = {
  '1': 'GetProjectsByUserIdRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetProjectsByUserIdRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectsByUserIdRequestDescriptor = $convert.base64Decode(
    'ChpHZXRQcm9qZWN0c0J5VXNlcklkUmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQ=');

@$core.Deprecated('Use getProjectsByUserIdResponseDescriptor instead')
const GetProjectsByUserIdResponse$json = {
  '1': 'GetProjectsByUserIdResponse',
  '2': [
    {'1': 'projects', '3': 1, '4': 3, '5': 11, '6': '.api.Project', '10': 'projects'},
  ],
};

/// Descriptor for `GetProjectsByUserIdResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectsByUserIdResponseDescriptor = $convert.base64Decode(
    'ChtHZXRQcm9qZWN0c0J5VXNlcklkUmVzcG9uc2USKAoIcHJvamVjdHMYASADKAsyDC5hcGkuUH'
    'JvamVjdFIIcHJvamVjdHM=');

@$core.Deprecated('Use projectDescriptor instead')
const Project$json = {
  '1': 'Project',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `Project`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectDescriptor = $convert.base64Decode(
    'CgdQcm9qZWN0Eg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSFwoHdXNlcl'
    '9pZBgDIAEoCVIGdXNlcklk');

