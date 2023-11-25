import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/quiz/state.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';
import 'package:furniture/domain/types/types.dart';

class QuizSelectDialog extends ConsumerStatefulWidget {
  const QuizSelectDialog({
    required this.genre,
    super.key
  });

  final GENRE genre;

  @override
  QuizSelectDialogState createState() => QuizSelectDialogState();
}

class QuizSelectDialogState extends ConsumerState<QuizSelectDialog> {

  // チェックボックスで選択されているアイテム
  List<String> checkedItems = [];

  @override
  Widget build(BuildContext context) {
    final rangeListAsyncData = ref.watch(questionRangeListNotifierProvider);
    final rangeListNotifier = ref.read(questionRangeListNotifierProvider.notifier);
    rangeListNotifier.updateState(widget.genre);
    final rangeList = rangeListAsyncData.when(
        data: (d) => d,
        error: (e, s) => ['error'],
        loading: () => ['loading']
    );

    // ----------------------------- メソッド -----------------------------
    void onChanged(e) {
      setState(() {
        if (checkedItems.contains(e)) {
          // すでにチェックされていたら取り除く
          checkedItems.remove(e);
        } else {
          // まだチェックされていなければ追加
          checkedItems.add(e);
        }
      });
    }

    Future<List<String>> convertItemsToDatabaseIds() async {

      final service = FirestoreService();
      List<String> ids = [];

      // デザイナーが選択されているとき
      if(widget.genre == GENRE.designer){
        for (String item in checkedItems){  // list.foreachやと非同期処理が上手くいかない。原因不明。
          String id = await service.searchDesignerId(item);
          ids.add(id);
        }
      }
      // ブランドが選択されているとき
      else if(widget.genre == GENRE.brand) {
        for (String item in checkedItems){
          String id = await service.searchBrandId(item);
          ids.add(id);
        }
      }
      // 文化が選択されているとき
      else if(widget.genre == GENRE.culture) {
        // TODO : デザイナーから文化を検索して、そのデザイナーIDを返す
        ids.add('genre');
      }
      return ids;
    }

    // ----------------------------- ウィジェット -----------------------------
    final checkboxListView = CheckBoxListView(
      ids: checkedItems,
      onChanged: onChanged,
      values: rangeList,
    );

    final buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonL(
            text: '戻る',
            onPressed: (){
              Navigator.pop(context, <String>[]);
            }
        ),
        ButtonL(
            text: '決定',
            onPressed: () async {
              final targets = await convertItemsToDatabaseIds();
              Navigator.pop(context, targets); // 絞り込み結果を送る
            }
        ),
      ],
    );

    // ----------------------------- ダイアログ -----------------------------
    return Dialog(
      child: Column(
        children: [
          Flexible(
              flex: 9,
              child: checkboxListView,
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: buttonRow,
            ),
          ),
        ],
      ),
    );
  }
}
