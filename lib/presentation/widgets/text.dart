import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';

class QuizText extends StatelessWidget {
  const QuizText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      // 4行まではきちんと表示されてそれ以上はあふれる → スペースに合わせた文字の大きさある？
      child: Text(text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 25), ),
    );
  }
}

class FurnitureDetailsText extends StatelessWidget {
  const FurnitureDetailsText(this.furniture, {super.key});

  final Furniture furniture;

  @override
  Widget build(BuildContext context) {
    final info =
        '名称　　　 : ${furniture.jaName}\n'
        'デザイナー : ${furniture.designer.jaName}\n'
        'ブランド　 : ${furniture.brand.jaName}\n'
        '誕生年　　 : ${furniture.designedYear}年\n'
        '種類　　　 : ${furniture.type}';

    final text = Text(info, style: const TextStyle(fontSize: 20),);

    return text;
    //   SizedBox(
    //   height: 150,
    //   // 4行まではきちんと表示されてそれ以上はあふれる → スペースに合わせた文字の大きさある？
    //   child: text
    // );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 24),);
  }
}
