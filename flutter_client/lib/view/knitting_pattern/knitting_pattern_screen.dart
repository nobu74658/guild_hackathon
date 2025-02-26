import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/view/knitting_pattern/components/knitting_pattern_viewer.dart';

class KnittingPatternScreen extends HookWidget {
  const KnittingPatternScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final color = useState(Colors.red);

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
                    height: 250,
                    width: double.infinity,
                    // MediaQuery.of(context).size.height * 0.5, // 高さを調整
                    // color: Colors.white.withOpacity(0.8), // 半透明にする
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
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
                                child: Icon(
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
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1,
                                    ),
                                    // borderRadius: BorderRadius.circular(2),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  // padding: const EdgeInsets.symmetric(
                                  // horizontal: 10),
                                  margin: EdgeInsets.all(5),
                                  alignment: Alignment.topLeft,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.circle),
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
