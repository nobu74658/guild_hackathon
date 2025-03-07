import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/manager/project_manager.dart';
import 'package:knitting/app/state/color_palettes_state.dart';
import 'package:knitting/app/use_case/create_new_pattern_use_case.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/common/router.dart';
import 'package:knitting/model/entities/project.dart';
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/components/show_dialog.dart';
import 'package:knitting/view/knitting_pattern_list/components/setting_dialog.dart';

class KnittingPatternListScreen extends HookConsumerWidget {
  const KnittingPatternListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final border = Border.all(
      color: Colors.white70,
      width: 2,
    );
    const appBarHeight = kToolbarHeight;
    final colorPalettes = ref.watch(colorPalettesStateProvider);

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
      body: StreamBuilder(
        stream: ref.read(projectManagerProvider).stream(),
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
              itemCount: (snapshot.data?.length ?? 0) + 1,
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
                          builder: (context) => const ConnectedSettingDialog(),
                        );

                        if (result == null) {
                          return;
                        }

                        if (context.mounted) {
                          SD.circular(context);

                          img.Image image;

                          try {
                            image = await ref
                                .read(createNewPatternUseCaseProvider)
                                .call(result.$1);
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'エラーが発生しました\nネットワーク環境を確認して再度お試しください',
                                  ),
                                ),
                              );
                            }
                            return;
                          }

                          if (context.mounted) {
                            Navigator.pop(context);
                            KnittingPatternRoute(
                              $extra: KnittingPatternRouteData(
                                projectId: null,
                                imagePath: null,
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
                return _Tile(
                  project: snapshot.data![index - 1],
                  paletteColors: colorPalettes.firstOrNull?.paletteColors ??
                      [
                        Colors.white,
                        Colors.black,
                      ],
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

class _Tile extends ConsumerWidget {
  const _Tile({required this.project, required this.paletteColors});

  final Project project;
  final List<Color> paletteColors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        final file = File(project.imagePath);
        if (!file.existsSync()) {
          return;
        }
        final image = img.decodeImage(file.readAsBytesSync());
        if (image == null) {
          return;
        }
        KnittingPatternRoute(
          $extra: KnittingPatternRouteData(
            projectId: project.projectId,
            imagePath: project.imagePath,
            image: image,
            knittingType: KnittingType.singleCrochet,
            colorPalette: paletteColors, // TODO(nobu): 編み図の色を取得する
          ),
        ).push(context);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border.all(
                color: Colors.white70,
                width: 2,
              ),
            ),
            child: Image.file(
              File(project.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('削除しますか？'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ref
                              .read(projectManagerProvider)
                              .deleteProject(projectId: project.projectId);
                        },
                        child: const Text('削除'),
                      ),
                    ],
                  );
                },
              ),
              icon: const Icon(
                Icons.delete,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
