import 'package:flutter/material.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';

class MemoDialog extends StatelessWidget {
  MemoDialog({required this.memo, super.key});

  final String memo;
  late final controller = TextEditingController(text: memo);

  @override
  Widget build(BuildContext context) {

    /// ボタン
    final updateButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context, controller.text);
      },
      child: const Text('更新'),
    );
    final cancelButton = ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('キャンセル'),
    );

    /// 部品
    final top = Container(
      height: 50,
      color: Colors.blue,
      child: const Row( // TODO: FittedBoxでどうにかなる？
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DialogTitleText('メモ'),
        ],
      ),
    );
    final body = Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 17,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
    final bottom = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 110,
            child: cancelButton,
          ),
          SizedBox(
            width: 110,
            child: updateButton,
          ),
        ],
      ),
    );

    /// ウィジェット
    return SingleChildScrollView( // キーボードを表示したときにオーバーフローすることを防ぐ
      child: Dialog(
        child: SizedBox(
          height: 500,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              top,
              body,
              bottom,
            ],
          ),
        ),
      ),
    );
  }
}
