import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/application/usecase/quiz/check_last.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/application/usecase/quiz/quiz_usecase.dart';

@RoutePage()
class PageQuiz extends ConsumerWidget {
  const PageQuiz({required this.list, super.key});

  final List<Furniture> list;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ----------------------------------- ステイト -----------------------------------
    final index = ref.watch(indexNotifierProvider);
    final isQuestion = ref.watch(isQuestionNotifierProvider);

    // 画像ステイトを監視
    final imageAsyncValue = ref.watch(imageNotifierProvider);
    final image = imageAsyncValue.when(
      data: (d) => ImageL(d),
      error: (e, s) => ImageL(Images.error),
      loading: () => ImageL(Images.loading),
    );

    // 詳細テキストステイトを監視
    final details = ref.watch(detailsNotifierProvider);
    final detailsText = QuizText(details);

    // ----------------------------------- ボタン -----------------------------------
    final answerButton = ButtonL(
      text: '答え',
      onPressed: () {
        final isQuestionNoti = ref.read(isQuestionNotifierProvider.notifier);
        final showAnswer = ShowAnswerUsecase(notifier: isQuestionNoti);
        showAnswer.showAnswer();
      },
    );

    final nextButton = ButtonL(
      text: '次へ',
      onPressed: () async {
        final checkLast = CheckLastUsecase();

        // 最後の問題
        if (checkLast.checkLast(index, list)) {
          final endAction = EndActionUsecase(ref: ref);
          endAction.complete(list, context);
        }
        // 最後の問題以外
        else {
          final nextQuestion = ChangeQuestionUsecase(ref: ref);
          nextQuestion.nextQuestion(list);
        }
      },
    );

    final homeButton = IconButton(
      icon: const Icon(Icons.home),
      onPressed: () {
        Navigator.pop(context, QuizEndAction.end);
      },
    );

    final backButton = IconButton(
      icon: const Icon(Icons.replay),
      onPressed: () {
        final usecase = ChangeQuestionUsecase(ref: ref);
        usecase.backQuestion(list);
      },
    );

    // ----------------------------------- アイコン行 -----------------------------------
    final iconRow = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        homeButton,
        backButton,
      ],
    );

    // ----------------------------------- ページ -----------------------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconRow,
        image,
        isQuestion ? const QuizText('この家具は何でしょう？') : detailsText,
        isQuestion ? answerButton : nextButton,
      ],
    );
  }
}
