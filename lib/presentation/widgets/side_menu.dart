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
      shape: Border(bottom: BorderSide(color: Colors.grey)),
    );

    /// ボディ
    Widget searchRows(List<CategoryAndHit> data, Function()? onTap) {

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

    const hitData = <CategoryAndHit>[
      CategoryAndHit(category: 'デザイナー', hit: 'ハンス・J・ウェグナー, アルヴァ・アアルト, アルネ・ヤコブセン, ボーエ・モーエ...'),
      CategoryAndHit(category: 'ブランド', ),
      CategoryAndHit(category: 'タイプ', ),
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

class CategoryAndHit{
  const CategoryAndHit({required this.category, this.hit});

  final String category;
  final String? hit;

  String get hitState => hit ?? '指定しない';
}
