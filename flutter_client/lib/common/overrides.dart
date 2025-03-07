import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infra/fake_project_repository.dart';
import 'package:knitting/infra/project_fast_api_repository.dart';
import 'package:knitting/infra/project_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class Overrides {
  static String get _env => const String.fromEnvironment('flavor');
  static List<Override> get value {
    switch (_env) {
      case 'dev':
        return _devInfra;
      case 'stg':
        return _stgInfra;
      default:
        return [];
    }
  }

  static final List<Override> _devInfra = [
    projectRepositoryProvider.overrideWithValue(FakeProjectRepository()),
  ];

  static final List<Override> _stgInfra = [
    projectRepositoryProvider.overrideWithValue(ProjectFastApiRepository()),
  ];
}
