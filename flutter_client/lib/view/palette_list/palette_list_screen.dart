import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:knitting/common/color.dart';

class PaletteListScreen extends HookWidget {
  const PaletteListScreen({super.key});

  static const path = '/palette';

  @override
  Widget build(BuildContext context) {
    final border = Border.all(
      color: Colors.white70,
      width: 2,
    );

    final color = useState(Colors.black);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
      ),
      body: ListView.builder(
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('色を選択'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: Colors.blue,
                            onColorChanged: (Color color_) {
                              color.value = color_;
                              // print(color.value);
                            },
                          ),
                        ),
                        actions: [
                          IconButton(
                            onPressed: () {
                              print(color.value);
                            },
                            icon: const Icon(CupertinoIcons.add),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          }
          return null;
        },
      ),
    );
  }
}
