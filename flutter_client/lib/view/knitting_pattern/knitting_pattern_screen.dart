import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/app/knitting_pattern_manager.dart';
import 'package:knitting/model/color_palette_type.dart';
import 'package:knitting/model/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';
import 'package:knitting/view/knitting_pattern/components/palette_circle.dart';

class DebugKnittingPatternScreen extends ConsumerWidget {
  const DebugKnittingPatternScreen({
    required this.knittingType,
    super.key,
  });

  final KnittingType knittingType;

  static const path = '/debug-edit';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.read(knittingPatternManagerProvider).fetchImage();
    final texture = ref.watch(knittingPatternManagerProvider).fetchTexture();
    final future = Future.wait([image, texture]);

    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _KnittingPatternScreen(
            image: snapshot.data![0] as img.Image,
            texture: snapshot.data![1] as ui.Image,
            knittingType: knittingType,
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
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
    super.key,
  });

  static const path = '/edit';

  final img.Image image;
  final KnittingType knittingType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future<ui.Image> texture =
        ref.watch(knittingPatternManagerProvider).fetchTexture();

    return FutureBuilder(
      future: texture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _KnittingPatternScreen(
            image: image,
            texture: snapshot.data!,
            knittingType: knittingType,
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
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
  });

  final img.Image image;
  final ui.Image texture;
  final KnittingType knittingType;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    PersistentBottomSheetController? controller;

    final colorPalette = ColorPaletteType.first.paletteColors;
    final color = useValueNotifier(colorPalette.first);
    final scale = useValueNotifier<double>(1.0); // useValueNotifier に変更

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
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_turn_up_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_turn_up_right),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(scaffoldKey.currentContext ?? context)
              .viewPadding
              .bottom,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          color: Colors.white,
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
                ],
              ),
              ValueListenableBuilder<double>(
                valueListenable: scale,
                builder: (context, value, child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 3,
                        thumbColor: Colors.grey[400],
                        activeTrackColor: Colors.grey[400],
                      ),
                      child: Slider(
                        value: value,
                        min: 1,
                        max: 8,
                        // スライドしてる位置の値が表示される、無いものを想定してたけどあっても便利かも？
                        label: value.toStringAsFixed(1),
                        onChanged: (newValue) {
                          scale.value = newValue; // スライダーの値を更新
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ValueListenableBuilder<double>(
          valueListenable: scale,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: ValueListenableBuilder<Color>(
                valueListenable: color,
                builder: (context, value, child) {
                  return KnittingPatternViewer(
                    image: image,
                    texture: texture,
                    knittingType: knittingType,
                    maxHeight: constraints.maxHeight,
                    selectedColor: value,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
