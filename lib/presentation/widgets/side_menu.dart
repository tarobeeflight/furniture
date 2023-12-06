import 'package:flutter/material.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';

class FurnitureSearchMenu extends StatelessWidget {
  const FurnitureSearchMenu({super.key});

  @override
  Widget build(BuildContext context) {
    /// ヘッダー
    final header = ListTile(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.close)
        ),
        title: Text('絞り込み', style: MyStyle.middleBlackBold,),
        trailing: TextButton(
          onPressed: (){},
          child: const Text('クリア'),
        ),
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
    );

    /// 各行
    Widget searchRows(List<_CategoryAndHit> data, Function()? onTap) {

      final List<Widget> contents = data.map((e) =>
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: onTap,
                      child:
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(e.category, style: MyStyle.smallBlackBold)
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 0),
                              child: Text(e.hitState, style: MyStyle.smallBlack, textAlign: TextAlign.right,),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                              child: Icon(Icons.arrow_forward_ios)
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
      ).toList();

      /// ボディ
      final body = Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          children: contents,
        ),
      );

      return body;
    }

    final searchButton = SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
      onPressed: (){},
      child: const Text('検索'),
      ),
    );

    const hitData = <_CategoryAndHit>[
      _CategoryAndHit(category: 'デザイナー', hit: 'ハンス・J・ウェグナー, アルヴァ・アアルト, アルネ・ヤコブセン, ボーエ・モーエ...'),
      _CategoryAndHit(category: 'ブランド', ),
      _CategoryAndHit(category: 'タイプ', ),
    ];

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: header,
          ),
          Flexible(
            flex: 9,
            child: ListView(
              children: [searchRows(hitData, () => debugPrint('on tap'))],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: searchButton,
          ),
        ],
    );
  }
}

class CheckMenu extends StatefulWidget {
  const CheckMenu({required this.category, required this.choices, super.key});

  final String category;
  final List<String> choices;

  @override
  State<CheckMenu> createState() => _CheckMenuState();
}

class _CheckMenuState extends State<CheckMenu> {
  Set<String> checkedIds = {};

  @override
  Widget build(BuildContext context) {

    /// チェックボックス
    void onChanged(String id) {
      if(checkedIds.contains(id)){
        setState(() {
          checkedIds.remove(id);
        });
      }
      else {
        setState(() {
          checkedIds.add(id);
        });
      }
      
      // debugPrint('$checkedIds');
    }
    void onChangedAllTile(){}
    final List<Widget> checkBox = widget.choices.map<Widget>((e) {
      return CheckboxListTile(
        value: checkedIds.contains(e),
        onChanged: (check) => onChanged(e),
        title: Text(e, style: MyStyle.smallBlack,),
      );
    }).toList();

    /// すべて選択の欄
    final Widget all = ListTile(
      onTap: onChangedAllTile,
      title: const Text('すべて'),
    );
    checkBox.insert(0, all);

    /// ボディ
    final body = ListView(
      children: checkBox,
    );

    /// ヘッダー
    final header = ListTile(
      leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back)
      ),
      title: Text(widget.category, style: MyStyle.middleBlackBold,),
      trailing: TextButton(
        onPressed: (){},
        child: const Text('クリア'),
      ),
      shape: const Border(bottom: BorderSide(color: Colors.grey)),
    );


    /// ボタン
    final decideButton = SizedBox(
      height: 60,
      width: 200,
      child: ElevatedButton(
        onPressed: (){},
        child: Text('決定', style: MyStyle.smallBlackBold,),
      ),
    );

    return Column(
      children: [
        Flexible(
          flex: 1,
          child: header,
        ),
        Flexible(
          flex: 9,
          child: body,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: decideButton,
        ),
      ],
    );
  }
}


class _CategoryAndHit{
  const _CategoryAndHit({required this.category, this.hit});

  final String category;
  final String? hit;

  String get hitState => hit ?? '指定しない';
}
