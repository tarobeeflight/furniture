import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/application/usecase/quiz/quiz_usecase.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:flutter/material.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:auto_route/auto_route.dart';

class EndActionUsecase {
  EndActionUsecase({
    required this.ref,
  });

  WidgetRef ref;

  void complete(List<Furniture> list, BuildContext context) async {
    final endAction = await showDialog(
      context: context,
      builder: (_) => const QuizEndDialog(),
    );
    // リトライ
    if (endAction == QuizEndAction.retry) {
      final usecase = EndActionUsecase(ref: ref);
      usecase.retry(list);
    }
    // 終了
    else if (endAction == QuizEndAction.end) {
      final usecase = EndActionUsecase(ref: ref);
      usecase.end();
      context.popRoute();
    }
  }

  void retry(List<Furniture> list) {
    // インデックスを0に戻す
    final iNoti = ref.read(indexNotifierProvider.notifier);
    iNoti.resetState();
    // 問題を更新
    final index = ref.read(indexNotifierProvider);
    final usecase = UpdateQuestionUsecase(ref: ref);
    usecase.updateQuestion(list.elementAt(index));
  }

  void end(){
    // インデックスを0に戻す
    final iNoti = ref.read(indexNotifierProvider.notifier);
    iNoti.resetState();
  }
}
