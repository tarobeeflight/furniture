import 'package:flutter/cupertino.dart';
import 'package:furniture/application/usecase/database/database_usecase.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/domain/types/types.dart';

class FurnitureDbUsecase {

  String convertToField(GENRE genre) {
    final field = switch(genre) {
      GENRE.all => FurnitureField.all,
      GENRE.designer => FurnitureField.designerId,
      GENRE.brand => FurnitureField.brandId,
      GENRE.culture => 'culture',
    };

    return field;
  }

  // TODO: ランダムで取得するようにする
  Future<List<Furniture>> getRandomFurniture(int limit, GENRE genre, List<String>? targets) async {
    /// クエリを作成
    final query = DbQuery(
      collection: Collection.furniture,
      property: convertToField(genre),
      targets: targets ?? [],
      // ここではlimitは設けず、あとから抽出する
    );

    /// DBから取得した家具リストからランダムに抽出
    final service = FirestoreService();
    final fList = await service.readFurnitureList(query);

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