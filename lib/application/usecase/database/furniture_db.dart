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
    // クエリを作成
    final query = DbQuery(
      collection: Collection.furniture,
      property: convertToField(genre),
      targets: targets ?? [],
      limit: limit,
    );

    // DBから家具リストを取得
    final service = FirestoreService();
    final list = await service.readFurnitureList(query);

    return list;
  }
}