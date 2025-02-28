//
//  Generated code. Do not modify.
//  source: projects.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class GetProjectsRequest extends $pb.GeneratedMessage {
  factory GetProjectsRequest({
    $core.String? userId,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    return $result;
  }
  GetProjectsRequest._() : super();
  factory GetProjectsRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProjectsRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProjectsRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProjectsRequest clone() => GetProjectsRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProjectsRequest copyWith(void Function(GetProjectsRequest) updates) => super.copyWith((message) => updates(message as GetProjectsRequest)) as GetProjectsRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProjectsRequest create() => GetProjectsRequest._();
  GetProjectsRequest createEmptyInstance() => create();
  static $pb.PbList<GetProjectsRequest> createRepeated() => $pb.PbList<GetProjectsRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProjectsRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProjectsRequest>(create);
  static GetProjectsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);
}

class CreateProjectRequest extends $pb.GeneratedMessage {
  factory CreateProjectRequest({
    $core.String? userId,
    $core.String? title,
    $core.List<$core.int>? image,
    $core.Iterable<$core.String>? colors,
    $core.String? knittingType,
  }) {
    final $result = create();
    if (userId != null) {
      $result.userId = userId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (image != null) {
      $result.image = image;
    }
    if (colors != null) {
      $result.colors.addAll(colors);
    }
    if (knittingType != null) {
      $result.knittingType = knittingType;
    }
    return $result;
  }
  CreateProjectRequest._() : super();
  factory CreateProjectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CreateProjectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CreateProjectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'userId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'image', $pb.PbFieldType.OY)
    ..pPS(4, _omitFieldNames ? '' : 'colors')
    ..aOS(5, _omitFieldNames ? '' : 'knittingType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CreateProjectRequest clone() => CreateProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CreateProjectRequest copyWith(void Function(CreateProjectRequest) updates) => super.copyWith((message) => updates(message as CreateProjectRequest)) as CreateProjectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CreateProjectRequest create() => CreateProjectRequest._();
  CreateProjectRequest createEmptyInstance() => create();
  static $pb.PbList<CreateProjectRequest> createRepeated() => $pb.PbList<CreateProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static CreateProjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CreateProjectRequest>(create);
  static CreateProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get userId => $_getSZ(0);
  @$pb.TagNumber(1)
  set userId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get image => $_getN(2);
  @$pb.TagNumber(3)
  set image($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasImage() => $_has(2);
  @$pb.TagNumber(3)
  void clearImage() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.String> get colors => $_getList(3);

  @$pb.TagNumber(5)
  $core.String get knittingType => $_getSZ(4);
  @$pb.TagNumber(5)
  set knittingType($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasKnittingType() => $_has(4);
  @$pb.TagNumber(5)
  void clearKnittingType() => clearField(5);
}

class GetProjectRequest extends $pb.GeneratedMessage {
  factory GetProjectRequest({
    $core.String? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  GetProjectRequest._() : super();
  factory GetProjectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProjectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProjectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProjectRequest clone() => GetProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProjectRequest copyWith(void Function(GetProjectRequest) updates) => super.copyWith((message) => updates(message as GetProjectRequest)) as GetProjectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProjectRequest create() => GetProjectRequest._();
  GetProjectRequest createEmptyInstance() => create();
  static $pb.PbList<GetProjectRequest> createRepeated() => $pb.PbList<GetProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProjectRequest>(create);
  static GetProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class UpdateProjectRequest extends $pb.GeneratedMessage {
  factory UpdateProjectRequest({
    $core.String? id,
    $core.String? title,
    $core.String? knittingType,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (knittingType != null) {
      $result.knittingType = knittingType;
    }
    return $result;
  }
  UpdateProjectRequest._() : super();
  factory UpdateProjectRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateProjectRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateProjectRequest', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'knittingType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateProjectRequest clone() => UpdateProjectRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateProjectRequest copyWith(void Function(UpdateProjectRequest) updates) => super.copyWith((message) => updates(message as UpdateProjectRequest)) as UpdateProjectRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateProjectRequest create() => UpdateProjectRequest._();
  UpdateProjectRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateProjectRequest> createRepeated() => $pb.PbList<UpdateProjectRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateProjectRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateProjectRequest>(create);
  static UpdateProjectRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get knittingType => $_getSZ(2);
  @$pb.TagNumber(3)
  set knittingType($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasKnittingType() => $_has(2);
  @$pb.TagNumber(3)
  void clearKnittingType() => clearField(3);
}

class GetProjectsResponse extends $pb.GeneratedMessage {
  factory GetProjectsResponse({
    $core.Iterable<Project>? projects,
  }) {
    final $result = create();
    if (projects != null) {
      $result.projects.addAll(projects);
    }
    return $result;
  }
  GetProjectsResponse._() : super();
  factory GetProjectsResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory GetProjectsResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'GetProjectsResponse', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..pc<Project>(1, _omitFieldNames ? '' : 'projects', $pb.PbFieldType.PM, subBuilder: Project.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  GetProjectsResponse clone() => GetProjectsResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  GetProjectsResponse copyWith(void Function(GetProjectsResponse) updates) => super.copyWith((message) => updates(message as GetProjectsResponse)) as GetProjectsResponse;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProjectsResponse create() => GetProjectsResponse._();
  GetProjectsResponse createEmptyInstance() => create();
  static $pb.PbList<GetProjectsResponse> createRepeated() => $pb.PbList<GetProjectsResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProjectsResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetProjectsResponse>(create);
  static GetProjectsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<Project> get projects => $_getList(0);
}

class Project extends $pb.GeneratedMessage {
  factory Project({
    $core.String? id,
    $core.String? userId,
    $core.String? title,
    $core.String? imageUrl,
    $core.Iterable<$core.String>? colors,
    $core.String? knittingType,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (userId != null) {
      $result.userId = userId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (imageUrl != null) {
      $result.imageUrl = imageUrl;
    }
    if (colors != null) {
      $result.colors.addAll(colors);
    }
    if (knittingType != null) {
      $result.knittingType = knittingType;
    }
    return $result;
  }
  Project._() : super();
  factory Project.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Project.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Project', package: const $pb.PackageName(_omitMessageNames ? '' : 'api'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'userId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'imageUrl')
    ..pPS(5, _omitFieldNames ? '' : 'colors')
    ..aOS(6, _omitFieldNames ? '' : 'knittingType')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Project clone() => Project()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Project copyWith(void Function(Project) updates) => super.copyWith((message) => updates(message as Project)) as Project;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Project create() => Project._();
  Project createEmptyInstance() => create();
  static $pb.PbList<Project> createRepeated() => $pb.PbList<Project>();
  @$core.pragma('dart2js:noInline')
  static Project getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Project>(create);
  static Project? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userId => $_getSZ(1);
  @$pb.TagNumber(2)
  set userId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get imageUrl => $_getSZ(3);
  @$pb.TagNumber(4)
  set imageUrl($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasImageUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearImageUrl() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.String> get colors => $_getList(4);

  @$pb.TagNumber(6)
  $core.String get knittingType => $_getSZ(5);
  @$pb.TagNumber(6)
  set knittingType($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasKnittingType() => $_has(5);
  @$pb.TagNumber(6)
  void clearKnittingType() => clearField(6);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
