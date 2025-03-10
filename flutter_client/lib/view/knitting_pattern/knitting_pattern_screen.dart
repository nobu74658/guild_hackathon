import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/manager/asset_image_manager.dart';
import 'package:knitting/app/manager/project_manager.dart';
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/components/show_dialog.dart';
import 'package:knitting/view/knitting_pattern/components/color_palette.dart';
import 'package:knitting/view/knitting_pattern/components/color_selector.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_selector.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';

enum BottomSheetType {
  color,
  knittingType,
}

enum EditModeType {
  paint,
  dropper,
}

class DebugKnittingPatternScreen extends ConsumerWidget {
  const DebugKnittingPatternScreen({
    required this.projectId,
    required this.imagePath,
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
    super.key,
  });

  final int? projectId;
  final String? imagePath;
  final KnittingType knittingType;
  final List<Color> colorPalette;
  final Color? backgroundColor;

  static const path = '/debug-edit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.read(assetImageManagerProvider).fetchImage();
    final texture = ref.read(assetImageManagerProvider).fetchTexture();
    final future = Future.wait([image, texture]);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _KnittingPatternScreen(
            projectId: projectId,
            imagePath: imagePath,
            image: snapshot.data![0] as img.Image,
            texture: snapshot.data![1] as ui.Image,
            knittingType: knittingType,
            colorPalette: colorPalette,
            backgroundColor: backgroundColor,
          );
        } else {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

class ConnectedKnittingPatternScreen extends ConsumerWidget {
  const ConnectedKnittingPatternScreen({
    required this.projectId,
    required this.imagePath,
    required this.image,
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
    super.key,
  });

  static const path = '/edit';

  final int? projectId;
  final String? imagePath;
  final img.Image image;
  final KnittingType knittingType;
  final List<Color> colorPalette;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<ui.Image> texture =
        ref.watch(assetImageManagerProvider).fetchTexture();

    return FutureBuilder(
      future: texture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _KnittingPatternScreen(
            projectId: projectId,
            imagePath: imagePath,
            image: image,
            texture: snapshot.data!,
            knittingType: knittingType,
            colorPalette: colorPalette,
            backgroundColor: backgroundColor,
          );
        } else {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

class _KnittingPatternScreen extends HookConsumerWidget {
  const _KnittingPatternScreen({
    required this.projectId,
    required this.imagePath,
    required this.image,
    required this.texture,
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
  });

  final int? projectId;
  final String? imagePath;
  final img.Image image;
  final ui.Image texture;
  final KnittingType knittingType;
  final List<Color> colorPalette;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    img.Image newImage = image;
    const activeColor = Colors.blue;
    final scaffoldKey = GlobalKey<ScaffoldState>();
    PersistentBottomSheetController? controller;

    final color = useValueNotifier(colorPalette.first);
    final selectedKnittingType = useValueNotifier(knittingType);
    BottomSheetType? lastSelectedBottomSheet;
    final editModeType = useValueNotifier(EditModeType.paint);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    SD.circular(context);
                    if (projectId == null || imagePath == null) {
                      await ref
                          .read(projectManagerProvider)
                          .saveProject(image: newImage);
                    } else {
                      await ref.read(projectManagerProvider).updateProject(
                            projectId: projectId!,
                            image: newImage,
                            imageUrl: imagePath!,
                          );
                    }
                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.save_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ValueListenableBuilder<KnittingType>(
          valueListenable: selectedKnittingType,
          builder: (context, knittingTypeValue, child) {
            return KnittingPatternViewer(
              image: image,
              texture: texture,
              knittingType: knittingTypeValue,
              maxHeight: constraints.maxHeight,
              selectedColor: color,
              backgroundColor: backgroundColor,
              editModeType: editModeType,
              onImageChanged: (img.Image value) {
                newImage = value;
              },
            );
          },
        ),
      ),
      bottomNavigationBar: ColoredBox(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(scaffoldKey.currentContext ?? context)
                .viewPadding
                .bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ColorSelector(
                      colorPalette: colorPalette,
                      color: color,
                      onTap: () {
                        final newController = _showBottomSheet(
                          widget: ColorPaletteBottomSheet(
                            onTap: (value) {
                              color.value = value;
                              Navigator.pop(context);
                              lastSelectedBottomSheet = null;
                            },
                            paletteColors: colorPalette,
                            selectedColor: color.value,
                          ),
                          bottomSheetType: BottomSheetType.color,
                          lastSelectedBottomSheet: lastSelectedBottomSheet,
                          scaffoldKey: scaffoldKey,
                          controller: controller,
                        );
                        controller = newController;
                        lastSelectedBottomSheet = BottomSheetType.color;
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: editModeType,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: () {
                            editModeType.value = EditModeType.dropper;
                          },
                          icon: Icon(
                            Icons.colorize_outlined,
                            color: value == EditModeType.dropper
                                ? activeColor
                                : null,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: editModeType,
                      builder: (context, value, child) {
                        return IconButton(
                          onPressed: () {
                            editModeType.value = EditModeType.paint;
                          },
                          icon: Icon(
                            Icons.brush_outlined,
                            color: value == EditModeType.paint
                                ? activeColor
                                : null,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        final newController = _showBottomSheet(
                          widget: KnittingPatternSelector(
                            onTap: (value) {
                              selectedKnittingType.value = value;
                              lastSelectedBottomSheet = null;
                              Navigator.pop(context);
                            },
                            selectedKnittingType: selectedKnittingType.value,
                          ),
                          scaffoldKey: scaffoldKey,
                          controller: controller,
                          bottomSheetType: BottomSheetType.knittingType,
                          lastSelectedBottomSheet: lastSelectedBottomSheet,
                        );
                        controller = newController;
                        lastSelectedBottomSheet = BottomSheetType.knittingType;
                      },
                      icon: const Icon(Icons.change_circle_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PersistentBottomSheetController? _showBottomSheet({
    required Widget widget,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required PersistentBottomSheetController? controller,
    required BottomSheetType bottomSheetType,
    required BottomSheetType? lastSelectedBottomSheet,
  }) {
    if (controller != null && bottomSheetType == lastSelectedBottomSheet) {
      controller.close();
      controller = null;
      return null;
    }

    controller = scaffoldKey.currentState?.showBottomSheet(
      (context) => widget,
      backgroundColor: Colors.white,
      enableDrag: true,
      showDragHandle: true,
    );
    return controller;
  }
}
