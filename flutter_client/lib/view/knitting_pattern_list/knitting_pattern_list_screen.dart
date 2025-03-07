import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knitting/app/manager/project_manager.dart';
import 'package:knitting/app/use_case/create_new_pattern_use_case.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/common/router.dart';
import 'package:knitting/model/types/knitting_type.dart';
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
    const appBarHeight = kToolbarHeight;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: SizedBox(
          height: appBarHeight - 10,
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              const PaletteListRoute().push(context);
            },
            icon: const Icon(Icons.palette_outlined),
          ),
        ],
      ),
      body: FutureBuilder(
        future: ref.read(projectManagerProvider).fetchAllProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('通信エラーが発生しました'),
            );
          }
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: knittingPatterns.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
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
                        final result = await showDialog<
                            (CreateNewPatternUseCaseParam, KnittingType)>(
                          context: context,
                          builder: (context) => const SettingDialog(),
                        );

                        if (result == null) {
                          return;
                        }

                        if (context.mounted) {
                          SD.circular(context);

                          final image = await ref
                              .read(createNewPatternUseCaseProvider)
                              .call(result.$1);

                          if (context.mounted) {
                            Navigator.pop(context);
                            KnittingPatternRoute(
                              $extra: KnittingPatternRouteData(
                                image: image,
                                knittingType: result.$2,
                                colorPalette: result.$1.colorPalette,
                              ),
                            ).push(context);
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
            );
          }
          return const Center(
            child: Text('No data available'),
          );
        },
      ),
    );
  }
}
