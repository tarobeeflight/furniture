import 'package:flutter/material.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';

class QuizEndDialog extends StatelessWidget {
  const QuizEndDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return
      AlertDialog(
        title: const Text('問題は以上です'),
        actions: [
          TextButtonFit(
            text: 'キャンセル',
            onPressed: () {
              Navigator.pop(context, QuizEndAction.cansel);
            },
          ),

          TextButtonFit(
            text: 'リトライ',
            onPressed: () {
              Navigator.pop(context, QuizEndAction.retry);
            },
          ),

          TextButtonFit(
              text: '終了',
              onPressed: () {
                Navigator.pop(context, QuizEndAction.end);
              }
          )
        ],
    );
  }
}

enum QuizEndAction {
  end,
  retry,
  cansel,
}