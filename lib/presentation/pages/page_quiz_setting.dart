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
class PageQuizSetting extends ConsumerStatefulWidget {
  const PageQuizSetting({super.key});

  @override
  PageQuizSettingState createState() => PageQuizSettingState();
}

class PageQuizSettingState extends ConsumerState<PageQuizSetting>{

  int? selectedRadioId;

  @override
  Widget build(BuildContext context)  { // ConsumerStateの場合,refは引数で取らないが持っている

    // ----------------------------------- ステイト -----------------------------------
    final index = ref.watch(indexNotifierProvider);
    final isQuestion = ref.watch(isQuestionNotifierProvider);

    final listState = ref.watch(listNotifierProvider);
    final list = listState.when(
      data: (d) => d,
      error: (e, s) => null,
      loading: () => null,
    );

    final details = ref.watch(detailsNotifierProvider);
    final detailsText = TestText(details);

    final imageState = ref.watch(imageNotifierProvider);
    final image = imageState.when(
      data: (d) => ImageL(d),
      error: (e, s) => ImageL(Images.error),
      loading: () => ImageL(Images.loading),
    );

    // ----------------------------------- ボタン -----------------------------------
    final decideButton = ButtonL(
        text: '決定',
        onPressed: () {
          // final usecase = UpdateQuestionUsecase(ref: ref);
          // usecase.updateQuestion(list!.elementAt(index));
        }
    );

    // ラジオボタンが押されたときの関数
    void onChanged(dynamic id) {
      setState(() {
        selectedRadioId = id;
      });
    }

    // ---------------テスト-------------------
    final numDropdownButton = DropdownButton(
        items: const [
          DropdownMenuItem(
            value: 10,
            child: Text('10'),
          ),
          DropdownMenuItem(
            value: 30,
            child: Text('30'),
          ),
          DropdownMenuItem(
            value: 50,
            child: Text('50'),
          ),
        ],
        onChanged: (int? num) {}
    );
    // ---------------テスト-------------------

    // ----------------------------------- ページ -----------------------------------
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            RadioButtonRow(
                id: selectedRadioId,
                onChanged: onChanged,
                values: const [10, 30, 50],
            ),
            ElevatedButton(
                onPressed: () {
                  // nullの場合分けも必要
                  // もしくはラジオボタンのデフォルトを10問にする
                  debugPrint('$selectedRadioId');
                },
                child: const Text('決定')
            ),
          ],
        ),
      ),
    );
  }
}
