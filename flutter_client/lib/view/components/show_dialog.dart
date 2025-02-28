import 'dart:async';

import 'package:flutter/material.dart';

class SD {
  static void circular(BuildContext context) {
    unawaited(
      showGeneralDialog(
        context: context,
        transitionDuration: Duration.zero,
        barrierColor: Colors.black.withAlpha(255 ~/ 4),
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) =>
            const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
