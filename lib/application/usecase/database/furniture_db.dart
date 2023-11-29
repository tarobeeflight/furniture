import 'package:flutter/cupertino.dart';
import 'package:furniture/application/usecase/database/database_usecase.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/domain/types/types.dart';

class FurnitureDbUsecase {

  String convertToField(GENRE genre) {
    final field = switch(genre) {
      GENRE.all => 'all',
      GENRE.designer => FurnitureField.designerId,
      GENRE.brand => FurnitureField.brandId,
      GENRE.culture => 'culture',
    };

    return field;
  }

  Future<List<Furniture>> getRandomFurniture(int limit, GENRE genre, List<String>? targets) async {
    /// 検索対象が存在すればクエリを作成
    FurnitureQuery? query;
    if(targets != null) {
      query = FurnitureQuery(
        property: convertToField(genre),
        targets: targets ?? [],
      );
    }

    /// DBから取得した家具リストからランダムに抽出
    final service = FirestoreService();
    final fList = await service.fetchFurniture(query);  // 検索対象があればクエリが入っていて、なければコレクションごと取得する

    final usecase = RandomUsecase();
    final indexList = usecase.getRandomNumList(fList.length);

    List<Furniture> questionList = [];
    final count = indexList.length < limit ? indexList.length : limit;
    for(int i = 0; i < count; i++){
      final f = fList.elementAt(indexList[i]);
      questionList.add(f);
    }

    return questionList;
  }
}