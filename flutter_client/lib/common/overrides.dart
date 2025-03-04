import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knitting/infra/fake_project_repository.dart';
import 'package:knitting/infra/project_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class Overrides {
  static List<Override> value =
      const bool.fromEnvironment('isFake') ? _fakeInfra : [];

  static final List<Override> _fakeInfra = [
    projectRepositoryProvider.overrideWithValue(FakeProjectRepository()),
  ];
}
