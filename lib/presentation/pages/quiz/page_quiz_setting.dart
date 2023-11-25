import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/router/app_router.gr.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/application/constants/quiz_constants.dart';
import 'package:furniture/application/usecase/quiz/quiz_usecase.dart';


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
    String getProperty(GENRE genre) {
      final property = switch(genre) {
        GENRE.all => FurnitureProperty.all,
        GENRE.designer => FurnitureProperty.designerId,
        GENRE.brand => FurnitureProperty.brandId,
        GENRE.culture => 'culture',
      };

      return property;
    }

    // --------------------------- ボタン ------------------------
    final decideButton = ButtonL(
      text: '決定',
      onPressed: () async {
        List<String>? ids;

        // 「全て」以外を選択中なら範囲選択ダイアログを表示
        if(genreRadioId != GENRE.all) {
          ids = await showDialog<List<String>>(
            context: context,
            builder: (_) => QuizSelectDialog(genre: genreRadioId,),
          );
        }

        // クエリを作成
        final query = DbQuery(
          collection: Collection.furniture,
          property: getProperty(genreRadioId),
          target: ids != null ? ids.first : '',
          limit: numRadioId,
        );

        // DBから家具リストを取得
        final service = FirestoreService();
        final fList = await service.readFurnitureList(query);

        // クイズページで１枚目から問題を表示するための苦肉の策
        final imageNoti = ref.watch(imageNotifierProvider.notifier);  // readだとダメ
        final detailsNoti = ref.watch(detailsNotifierProvider.notifier);
        imageNoti.updateState(fList.first.imageUrl);
        detailsNoti.updateState(fList.first);

        context.navigateTo(RouteQuiz(list: fList));
      }
    );

    // ----------------------------------- ページ -----------------------------------
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('問題数'),
            RadioButtonRow(
              id: numRadioId,
              onChanged: onChangedNumRadio,
              values: QuizConstants.quizNumChoices,
            ),
            const Text('絞り込み'),
            RadioButtonColumn(
              id: genreRadioId,
              onChanged: onChangedGenreRadio,
              values: GENRE.values,
            ),
            decideButton,
          ],
        ),
      ),
    );
  }
}
