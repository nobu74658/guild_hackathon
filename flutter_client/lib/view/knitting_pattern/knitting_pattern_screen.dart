import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';

class KnittingPatternScreen extends HookWidget {
  const KnittingPatternScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    final paletteColors = [
      Colors.yellow,
      Colors.red,
      Colors.blue,
      Colors.purple,
      Colors.grey,
      Colors.white
    ];
    final color = useState(paletteColors[0]);
    final scale = useValueNotifier<double>(1.0); // useValueNotifier に変更

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.arrow_turn_up_left),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.arrow_turn_up_right),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 150,
        child: Builder(
          builder: (scaffoldContext) => Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(scaffoldContext).viewPadding.bottom,
            ),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => showBottomSheet(
                        context: scaffoldContext,
                        builder: (context) => Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      'パレット',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                      ),
                                      onPressed: () => Navigator.pop(context),
                                      child: const Icon(
                                          IconData(0xf645,
                                              fontFamily: 'MaterialIcons'),
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       if (scale.value < 2.0) {
                    //         scale.value += 0.1;
                    //       }
                    //     },
                    //     child: const Text('Zoom In'),
                    //   ),
                    //   ElevatedButton(
                    //     onPressed: () {
                    //       if (scale.value > 0.5) {
                    //         scale.value -= 0.1;
                    //       }
                    //     },
                    //     child: const Text('Zoom Out'),
                    //   ),
                  ],
                ),
                ValueListenableBuilder<double>(
                  valueListenable: scale,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    );
                  },
                ),
              ],
            ),
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
                maxHeight: constraints.maxHeight,
              ),
            );
          },
        ),
      ),
    );
  }
}
