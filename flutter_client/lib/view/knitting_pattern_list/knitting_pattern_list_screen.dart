import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class KnittingPatternListScreen extends HookWidget {
  const KnittingPatternListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedSize = useState('8*8');
    final selectedKnittingPattern = useState('メリヤス編み');

    return Scaffold(
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              child: IconButton(
                color: Colors.grey,
                iconSize: 100,
                icon: const Icon(CupertinoIcons.add),
                onPressed: () => (BuildContext context) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "新規ノート",
                          textAlign: TextAlign.center,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Divider(),
                            // サイズ選択
                            ListTile(
                              title: const Text(
                                "サイズ",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: DropdownButton<String>(
                                // 文字を右寄せにするためにAlign使ったら表示されなくなっちゃった
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.grey[800],
                                ),
                                value: selectedSize.value,
                                items: ['8*8', '16*16', '24*24', '32*32']
                                    .map((size) => DropdownMenuItem(
                                          value: size,
                                          child: Text(size),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedSize.value = value;
                                  }
                                },
                              ),
                            ),
                            const Divider(),
                            // 編み地の種類選択
                            ListTile(
                              title: const Text(
                                "編み地",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                              ),
                              trailing: DropdownButton<String>(
                                // 文字を右寄せにするためにAlign使ったら表示されなくなっちゃった
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[800],
                                ),
                                value: selectedKnittingPattern.value,
                                items: [
                                  'メリヤス編み',
                                  '細編み(表)', // 本当は'輪編みの'が先頭につく
                                  '細編み(裏)', // 本当は'輪編みの'が先頭につく
                                  'すじ編み(表)', // 本当は'輪編みの'が先頭につく
                                  'すじ編み(裏)' // 本当は'輪編みの'が先頭につく
                                ]
                                    .map((knittingPattern) => DropdownMenuItem(
                                          value: knittingPattern,
                                          child: Text(knittingPattern),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    selectedKnittingPattern.value = value;
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  "キャンセル",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.indigo[400],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[600],
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: Text(
                                  "作成",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                }(context),
              ),
            );
          }
          return ColoredBox(color: Colors.primaries[index % 6]);
        },
      ),
    );
  }
}
