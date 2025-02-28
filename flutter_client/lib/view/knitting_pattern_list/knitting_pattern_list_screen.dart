import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:knitting/app/create_new_pattern_use_case.dart';
import 'package:knitting/app/project_manager.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/common/router.dart';
import 'package:knitting/model/types/create_type.dart';
import 'package:knitting/model/types/knitting_pattern_size.dart';
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
            'assets/logo.png',
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: ref.watch(projectManagerProvider).fetchAllProjects(),
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
                        final result = await showDialog(
                          context: context,
                          builder: (context) => const SettingDialog(),
                        );

                        if (result is! Map<String, dynamic>) {
                          return;
                        }

                        final createType = result['createType'];
                        final size = result['size'];
                        final xFile = result['image'];
                        final colorPalette = result['colorPalette'];
                        final knittingType = result['knittingType'];

                        if (size is! KnittingPatternSizeType ||
                            colorPalette is! List<Color> ||
                            knittingType is! KnittingType) {
                          debugPrint('size: $size');
                          debugPrint('colorPalette: $colorPalette');
                          debugPrint('knittingType: $knittingType');
                          return;
                        }

                        // createTypeの検証
                        if (createType is! CreateType) {
                          debugPrint('createType: $createType');
                          return;
                        }

                        // 画像の処理
                        img.Image? imageData;
                        if (createType == CreateType.image) {
                          // イメージモードの場合、XFileが必要
                          if (xFile is! XFile) {
                            debugPrint('image: $xFile (XFile required for image mode)');
                            return;
                          }
                          
                          try {
                            final bytes = await File(xFile.path).readAsBytes();
                            imageData = img.decodeImage(bytes);
                            if (imageData == null) {
                              debugPrint('Failed to decode image');
                              return;
                            }
                          } catch (e) {
                            debugPrint('Error loading image: $e');
                            return;
                          }
                        }

                        final param = CreateNewPatternUseCaseParam(
                          size: size,
                          image: imageData, // imageDataはCreateType.noteの場合はnull
                          colorPalette: colorPalette,
                          createType: createType,
                        );

                        if (context.mounted) {
                          SD.circular(context);

                          try {
                            final image = await ref
                                .read(createNewPatternUseCaseProvider)
                                .call(param);

                            if (context.mounted) {
                              Navigator.pop(context);
                              KnittingPatternRoute(
                                $extra: image,
                                knittingType: knittingType.value,
                              ).push(context);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('エラーが発生しました: $e'),
                                ),
                              );
                            }
                            debugPrint('Error creating pattern: $e');
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
