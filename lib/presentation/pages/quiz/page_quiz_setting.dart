import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/presentation/router/app_router.gr.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/application/constants/quiz_constants.dart';
import 'package:furniture/application/usecase/quiz/quiz_usecase.dart';
import 'package:furniture/application/usecase/database/database_usecase.dart';


@RoutePage()
class PageQuizSetting extends ConsumerStatefulWidget {
  const PageQuizSetting({super.key});

  @override
  PageQuizSettingState createState() => PageQuizSettingState();
}

class PageQuizSettingState extends ConsumerState<PageQuizSetting>{

  // ラジオボタンのデフォルト選択
  int numRadioId = QuizConstants.quizNumChoices.first;
  GENRE genreRadioId = GENRE.all;

  @override
  Widget build(BuildContext context)  { // ConsumerStateの場合,refは引数で取らないが持っている

    // --------------------------- メソッド ------------------------
    void onChangedNumRadio(dynamic id) {
      setState(() {
        numRadioId = id;
      });
    }
    void onChangedGenreRadio(dynamic id) {
      setState(() {
        genreRadioId = id;
      });
    }

    // --------------------------- ボタン ------------------------
    final decideButton = ButtonL(
      text: '決定',
      onPressed: () async {
        List<String>? ids;

        /// 「全て」以外を選択中なら範囲選択ダイアログを表示
        if(genreRadioId != GENRE.all) {
          ids = await showDialog<List<String>>(
            context: context,
            builder: (_) => QuizSelectDialog(genre: genreRadioId,),
          );
        }

        /// DBから家具リストをランダムで取得
        final usecase = FurnitureDbUsecase();
        final fList = await usecase.getRandomFurniture(numRadioId, genreRadioId, ids);


        /// クイズページで１枚目から問題を表示するための苦肉の策
        final imageNoti = ref.watch(imageNotifierProvider.notifier);  // readだとダメ
        final detailsNoti = ref.watch(detailsNotifierProvider.notifier);
        imageNoti.updateState(fList.first.imageUrl);
        detailsNoti.updateState(fList.first);

        /// クイズページに移動
        context.navigateTo(RouteQuiz(list: fList));
      }
    );

    // ----------------------------------- ページ -----------------------------------
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text('問題数', style: TextStyle(fontSize: 20),),
                RadioButtonRow(
                  id: numRadioId,
                  onChanged: onChangedNumRadio,
                  values: QuizConstants.quizNumChoices,
                ),
              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('絞り込み', style: TextStyle(fontSize: 20),),
                RadioButtonColumn(
                  id: genreRadioId,
                  onChanged: onChangedGenreRadio,
                  values: GENRE.values,
                ),
              ],
            ),

            decideButton,
          ],
        ),
      ),
    );
  }
}
