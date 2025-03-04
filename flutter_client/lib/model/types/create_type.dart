import 'package:flutter/material.dart';

enum CreateType {
  note('ノート', Icons.note_add_rounded),
  image('画像', Icons.camera_alt_rounded);

  const CreateType(this.label, this.iconData);

  final String label;
  final IconData iconData;
}
