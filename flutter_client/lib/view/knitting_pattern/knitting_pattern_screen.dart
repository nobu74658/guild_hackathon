import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/manager/asset_image_manager.dart';
import 'package:knitting/model/types/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/color_palette.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_selector.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';

class DebugKnittingPatternScreen extends ConsumerWidget {
  const DebugKnittingPatternScreen({
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
    super.key,
  });

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
    required this.image,
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
    super.key,
  });

  static const path = '/edit';

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

class _KnittingPatternScreen extends HookWidget {
  const _KnittingPatternScreen({
    required this.image,
    required this.texture,
    required this.knittingType,
    required this.colorPalette,
    required this.backgroundColor,
  });

  final img.Image image;
  final ui.Image texture;
  final KnittingType knittingType;
  final List<Color> colorPalette;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    PersistentBottomSheetController? controller;

    final color = useValueNotifier(colorPalette.first);
    final selectedKnittingType = useValueNotifier(knittingType);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(),
          ),
        ],
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
                    GestureDetector(
                      onTap: () {
                        if (controller != null) {
                          controller?.close();
                          controller = null;
                          return;
                        }

                        controller = scaffoldKey.currentState?.showBottomSheet(
                          (context) => ColorPalette(
                            onTap: (value) {
                              color.value = value;
                              Navigator.pop(context);
                            },
                            paletteColors: colorPalette,
                            selectedColor: color.value,
                          ),
                          backgroundColor: Colors.white,
                          enableDrag: true,
                          showDragHandle: true,
                        );
                        controller?.closed.then((value) {
                          controller = null;
                        });
                      },
                      child: ValueListenableBuilder<Color>(
                        valueListenable: color,
                        builder: (context, value, child) {
                          return Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: value,
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controller != null) {
                          controller?.close();
                          controller = null;
                          return;
                        }

                        controller = scaffoldKey.currentState?.showBottomSheet(
                          (context) => KnittingPatternSelector(
                            selectedKnittingType: selectedKnittingType.value,
                            onTap: (value) {
                              selectedKnittingType.value = value;
                              Navigator.pop(context);
                            },
                          ),
                          backgroundColor: Colors.white,
                          enableDrag: true,
                          showDragHandle: true,
                        );
                        controller?.closed.then((value) {
                          controller = null;
                        });
                      },
                      icon: const Icon(Icons.brush_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ValueListenableBuilder<Color>(
          valueListenable: color,
          builder: (context, colorValue, child) {
            return ValueListenableBuilder<KnittingType>(
              valueListenable: selectedKnittingType,
              builder: (context, knittingTypeValue, child) {
                return KnittingPatternViewer(
                  image: image,
                  texture: texture,
                  knittingType: knittingTypeValue,
                  maxHeight: constraints.maxHeight,
                  selectedColor: colorValue,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
