import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'grpc_repository.g.dart';

@Riverpod(keepAlive: true)
ClientChannel clientChannel(Ref ref) {
  const host = '10.0.2.2';
  return ClientChannel(
    host,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );
}
