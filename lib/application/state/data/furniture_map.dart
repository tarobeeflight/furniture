import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
part 'furniture_map.g.dart';

@riverpod
class FurnitureMapNotifier extends _$FurnitureMapNotifier {
  @override
   Future<Map<String, Furniture>> build() {
    final service = FirestoreService();
    final map = service.fetchFurnitureMap(null);
    return map;
  }

  void updateMemo(String id, String newMemo) {
    final map = state.value!.map<String, Furniture>((key, value) {
      /// メモを変更した家具データ
      if(key == id){
        final newFurniture = value.copyWith(memo: newMemo);
        return MapEntry<String, Furniture>(key, newFurniture);
      }
      /// それ以外
      else {
        return MapEntry<String, Furniture>(key, value);
      }
    });

    state = AsyncValue.data(map);
  }
}