import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/quiz/select_list/select_list.dart';
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

  List<String> checkIds = [];

  @override
  Widget build(BuildContext context) {
    final selectList = ref.watch(selectListNotifierProvider);

    // ----------------------------- メソッド -----------------------------
    void onChanged(e) {
      setState(() {
        if (checkIds.contains(e)) {
          // すでにチェックされていたら取り除く
          checkIds.remove(e);
        } else {
          // まだチェックされていなければ追加
          checkIds.add(e);
        }
      });
      debugPrint('$checkIds');
    }

    Future<List<String>> getTargets() async {
      // チェックボックスのセレクトリストからbrandId, designerIdなどに変換する
      final service = FirestoreService();

      List<String> targets = [];

      if(widget.genre == GENRE.designer){
        for (String id in checkIds){  // list.foreachやと非同期処理が上手くいかない。原因不明。
          String target = await service.searchDesignerId(id);
          debugPrint('designer target = ');
          debugPrint(target);
          targets.add(target);
        }
      } else if(widget.genre == GENRE.brand) {
        for (String id in checkIds){
          String target = await service.searchBrandId(id);
          debugPrint('brand target = ');
          debugPrint(target);
          targets.add(target);
        }
      } else if(widget.genre == GENRE.culture) {
        targets.add('genre');
      }
      return targets;
    }

    // ----------------------------- ウィジェット -----------------------------
    final checkboxListView = CheckBoxListView(
      ids: checkIds,
      onChanged: onChanged,
      values: selectList.when(
          data: (d) => d,
          error: (e, s) => ['error'],
          loading: () => ['loading']
      ),
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
              final targets = await getTargets();
              debugPrint('debug targets = ');
              debugPrint('$targets');
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
