import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/data/display_furniture_map/display_furniture_map.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';


@RoutePage()
class PageFurnitureDetails extends ConsumerWidget {
  PageFurnitureDetails({required this.id, required this.furniture, super.key});

  final String id;
  Furniture furniture;

  @override
  Widget build(BuildContext context, WidgetRef ref){
    void onPressed() async {
      /// メモダイアログを表示
      final newMemo = await showDialog<String?>(
        context: context,
        builder: (_) => MemoDialog(memo: furniture.memo),
      );
      
      /// メモが変更されたら
      if(newMemo != null && newMemo != furniture.memo){
        /// データベースを更新
        final service = FirestoreService();
        await service.updateFurnitureMemo(id, newMemo);

        /// フィールド変数を更新
        furniture = furniture.copyWith(memo: newMemo);

        /// 家具一覧ステイトを更新
        final notifier = ref.read(displayFurnitureMapNotifierProvider.notifier);
        notifier.updateMemo(id, newMemo);
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(furniture.jaName),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureImageL(url: furniture.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(furniture.enName),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.description)),
              ],
            ),
            FurnitureDetailsText(furniture),
          ],
        ),
      ),
    );
  }
}