import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knitting/app/create_new_pattern_use_case.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/common/router.dart';
import 'package:knitting/view/components/show_dialog.dart';
import 'package:knitting/view/knitting_pattern_list/components/setting_dialog.dart';

class KnittingPatternListScreen extends HookConsumerWidget {
  const KnittingPatternListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const knittingPatterns = [];
    final border = Border.all(
      color: Colors.white70,
      width: 2,
    );
    final appBarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: SizedBox(
          height: appBarHeight - 40,
          child: Image.asset(
            'assets/logo.png',
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: knittingPatterns.length + 1,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: border,
              ),
              child: IconButton(
                color: Colors.grey,
                iconSize: 100,
                icon: const Icon(CupertinoIcons.add),
                onPressed: () async {
                  final result = await showDialog(
                    context: context,
                    builder: (context) => const SettingDialog(),
                  );

                  if (result is! Map<String, dynamic>) {
                    return;
                  }

                  final size = result['size'];
                  final knittingPattern = result['knittingPattern'];
                  if (size == null || knittingPattern == null) {
                    return;
                  }

                  if (context.mounted) {
                    SD.circular(context);

                    final image = await ref
                        .read(createNewPatternUseCaseProvider)
                        .call(null);

                    if (context.mounted) {
                      Navigator.pop(context);
                      KnittingPatternRoute($extra: image).push(context);
                    }
                  }
                },
              ),
            );
          }
          return Container(
            decoration: BoxDecoration(
              color: Colors.primaries[index % 6],
              border: border,
            ),
          );
        },
      ),
    );
  }
}
