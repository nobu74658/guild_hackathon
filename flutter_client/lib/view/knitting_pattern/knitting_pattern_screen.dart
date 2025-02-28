import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image/image.dart' as img;
import 'package:knitting/model/knitting_type.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';
import 'package:knitting/view/knitting_pattern/components/palette_circle.dart';

class KnittingPatternScreen extends HookWidget {
  const KnittingPatternScreen({required this.image, super.key});

  static const path = '/edit';

  final img.Image image;

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    PersistentBottomSheetController? controller;

    final paletteColors = [
      Colors.yellow,
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.grey,
      Colors.white,
    ];
    final color = useState(paletteColors[0]);
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
                          paletteColors: paletteColors,
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
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: color.value,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(2),
                      ),
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
              child: ConnectedKnittingPatternViewer(
                knittingType: KnittingType.singleCrochet,
                maxHeight: constraints.maxHeight,
              ),
            );
          },
        ),
      ),
    );
  }
}
