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

    // final color1 = useState(paletteColors[0]);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // title: Text('arrow'),
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
                    icon: Icon(CupertinoIcons.arrow_turn_up_right))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Builder(
        builder: (scaffoldContext) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(scaffoldContext).viewPadding.bottom,
          ),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => showBottomSheet(
                  context: scaffoldContext, // Scaffoldのcontextを取得
                  builder: (context) => Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.white,
                    // MediaQuery.of(context).size.height * 0.5, // 高さを調整
                    // color: Colors.white.withOpacity(0.8), // 半透明にする
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                // 登録済みのパレットから選択中のものを表示したい(「パレット1」とか「コットンヤーン(毛糸の種類)」とか)けど、急ぎじゃない
                                'パレット',
                                style: TextStyle(
                                  // width:2,
                                  // height: 2,
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
                                onPressed: () =>
                                    Navigator.pop(context), // ボトムシートを閉じる
                                child: const Icon(
                                    IconData(0xf645,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        // 色塗りのパレットの色選択
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[0];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[0],
                                      border: Border.all(
                                        color: (paletteColors[0] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[0]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[1];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[1],
                                      border: Border.all(
                                        color: (paletteColors[1] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[1]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[2];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[2],
                                      border: Border.all(
                                        color: (paletteColors[2] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[2]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[3];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[3],
                                      border: Border.all(
                                        color: (paletteColors[3] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[3]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[4];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[4],
                                      border: Border.all(
                                        color: (paletteColors[4] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[4]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    color.value = paletteColors[5];
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // padding: const EdgeInsets.symmetric(
                                    // horizontal: 10),
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      color: paletteColors[5],
                                      border: Border.all(
                                        color: (paletteColors[5] == Colors.white
                                            ? Colors.grey
                                            : paletteColors[5]),
                                        width: 1,
                                      ),
                                      // borderRadius: BorderRadius.circular(2),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
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
                    // 選択中の色を表示
                    // color: Colors.pink[50],
                    color: color.value,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Zoom In'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Zoom Out'),
              ),
            ],
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => ConnectedKnittingPatternViewer(
          maxHeight: constraints.maxHeight,
        ),
      ),
    );
  }
}
