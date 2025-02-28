import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:knitting/app/create_new_pattern_use_case.dart';
import 'package:knitting/common/color.dart';
import 'package:knitting/common/router.dart';
import 'package:knitting/model/create_type.dart';
import 'package:knitting/model/knitting_pattern_size.dart';
import 'package:knitting/model/knitting_type.dart';
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

                  if (createType is! CreateType && xFile is! XFile) {
                    debugPrint('createType: $createType');
                    debugPrint('image: $xFile');

                    return;
                  }

                  // XFileからimg.Imageに変換
                  img.Image? imageData;
                  if (xFile is XFile) {
                    final bytes = await File(xFile.path).readAsBytes();
                    imageData = img.decodeImage(bytes);
                  }

                  final param = CreateNewPatternUseCaseParam(
                    size: size,
                    image: imageData,
                    colorPalette: colorPalette,
                    createType: createType,
                  );

                  if (context.mounted) {
                    SD.circular(context);

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
