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

@$core.Deprecated('Use getProjectsRequestDescriptor instead')
const GetProjectsRequest$json = {
  '1': 'GetProjectsRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
  ],
};

/// Descriptor for `GetProjectsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectsRequestDescriptor = $convert.base64Decode(
    'ChJHZXRQcm9qZWN0c1JlcXVlc3QSFwoHdXNlcl9pZBgBIAEoCVIGdXNlcklk');

@$core.Deprecated('Use createProjectRequestDescriptor instead')
const CreateProjectRequest$json = {
  '1': 'CreateProjectRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'image', '3': 3, '4': 1, '5': 12, '10': 'image'},
    {'1': 'colors', '3': 4, '4': 3, '5': 9, '10': 'colors'},
    {'1': 'knitting_type', '3': 5, '4': 1, '5': 9, '10': 'knittingType'},
  ],
};

/// Descriptor for `CreateProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createProjectRequestDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVQcm9qZWN0UmVxdWVzdBIXCgd1c2VyX2lkGAEgASgJUgZ1c2VySWQSFAoFdGl0bG'
    'UYAiABKAlSBXRpdGxlEhQKBWltYWdlGAMgASgMUgVpbWFnZRIWCgZjb2xvcnMYBCADKAlSBmNv'
    'bG9ycxIjCg1rbml0dGluZ190eXBlGAUgASgJUgxrbml0dGluZ1R5cGU=');

@$core.Deprecated('Use getProjectRequestDescriptor instead')
const GetProjectRequest$json = {
  '1': 'GetProjectRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `GetProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectRequestDescriptor = $convert.base64Decode(
    'ChFHZXRQcm9qZWN0UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQ=');

@$core.Deprecated('Use updateProjectRequestDescriptor instead')
const UpdateProjectRequest$json = {
  '1': 'UpdateProjectRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'knitting_type', '3': 3, '4': 1, '5': 9, '10': 'knittingType'},
  ],
};

/// Descriptor for `UpdateProjectRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProjectRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9qZWN0UmVxdWVzdBIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBX'
    'RpdGxlEiMKDWtuaXR0aW5nX3R5cGUYAyABKAlSDGtuaXR0aW5nVHlwZQ==');

@$core.Deprecated('Use getProjectsResponseDescriptor instead')
const GetProjectsResponse$json = {
  '1': 'GetProjectsResponse',
  '2': [
    {'1': 'projects', '3': 1, '4': 3, '5': 11, '6': '.api.Project', '10': 'projects'},
  ],
};

/// Descriptor for `GetProjectsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProjectsResponseDescriptor = $convert.base64Decode(
    'ChNHZXRQcm9qZWN0c1Jlc3BvbnNlEigKCHByb2plY3RzGAEgAygLMgwuYXBpLlByb2plY3RSCH'
    'Byb2plY3Rz');

@$core.Deprecated('Use projectDescriptor instead')
const Project$json = {
  '1': 'Project',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 9, '10': 'userId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'image_url', '3': 4, '4': 1, '5': 9, '10': 'imageUrl'},
    {'1': 'colors', '3': 5, '4': 3, '5': 9, '10': 'colors'},
    {'1': 'knitting_type', '3': 6, '4': 1, '5': 9, '10': 'knittingType'},
  ],
};

/// Descriptor for `Project`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List projectDescriptor = $convert.base64Decode(
    'CgdQcm9qZWN0Eg4KAmlkGAEgASgJUgJpZBIXCgd1c2VyX2lkGAIgASgJUgZ1c2VySWQSFAoFdG'
    'l0bGUYAyABKAlSBXRpdGxlEhsKCWltYWdlX3VybBgEIAEoCVIIaW1hZ2VVcmwSFgoGY29sb3Jz'
    'GAUgAygJUgZjb2xvcnMSIwoNa25pdHRpbmdfdHlwZRgGIAEoCVIMa25pdHRpbmdUeXBl');

