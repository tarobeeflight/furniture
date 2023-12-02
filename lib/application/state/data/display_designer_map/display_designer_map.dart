import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
part 'display_designer_map.g.dart';

@riverpod
class DisplayDesignerMapNotifier extends _$DisplayDesignerMapNotifier {
  @override
  Future<Map<String, Designer>> build() async {
    final service = FirestoreService();
    final map = await service.readDesignerMap();
    return map;
  }

  // TODO: DBメソッド実装 → ウィジェットに適用
  // Future<void> fetchState(/*DesignerQuery query*/) async {
  //   final service = FirestoreService();
  //   final map = await service.fetchDesignerMap(query);
  //   state = AsyncValue.data(map);
  // }
}