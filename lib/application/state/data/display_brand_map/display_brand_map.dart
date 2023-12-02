import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
part 'display_brand_map.g.dart';

@riverpod
class DisplayBrandMapNotifier extends _$DisplayBrandMapNotifier {
  @override
  Future<Map<String, Brand>> build() async {
    final service = FirestoreService();
    final map = await service.readBrandMap();
    return map;
  }

  // TODO: DBメソッド実装 → ウィジェットに適用
  // Future<void> fetchState(/*BrandQuery query*/) async {
  //   final service = FirestoreService();
  //   final map = await service.fetchBrandMap(query);
  //   state = AsyncValue.data(map);
  // }
}