import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/dialogs/my_dialogs.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';


@RoutePage()
class PageFurnitureDetails extends StatelessWidget {
  const PageFurnitureDetails({required this.furniture, super.key});

  final Furniture furniture;

  @override
  Widget build(BuildContext context){
    void onPressed() async {
      /// メモダイアログを表示
      final newMemo = await showDialog<String?>(
        context: context,
        builder: (_) => MemoDialog(memo: furniture.memo),
      );
      
      /// メモが変更されたらデータベースを更新
      if(newMemo != null && newMemo != furniture.memo){
        debugPrint('\n$newMemo\n');
        final service = FirestoreService();
        await service.updateFurnitureMemo('F0001', newMemo);
        // TODO: 引数でもらっているものをステイトにする
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