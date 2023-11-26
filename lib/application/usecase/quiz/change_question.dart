import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/application/usecase/quiz/quiz_usecase.dart';
import 'package:furniture/domain/types/types.dart';

class ChangeQuestionUsecase {
  ChangeQuestionUsecase({
    required this.ref,
  });

  WidgetRef ref;
  
  void nextQuestion(List<Furniture> list) {
    final iNoti = ref.watch(indexNotifierProvider.notifier);
    final index = iNoti.nextIndex();
    final usecase = UpdateQuestionUsecase(ref: ref,);
    usecase.updateQuestion(list.elementAt(index));
  }

  void backQuestion(List<Furniture> list) {
    final iNoti = ref.watch(indexNotifierProvider.notifier);
    final index = iNoti.backIndex();  // インデックスが0のときは不変
    final usecase = UpdateQuestionUsecase(ref: ref,);
    usecase.updateQuestion(list.elementAt(index));
  }
}