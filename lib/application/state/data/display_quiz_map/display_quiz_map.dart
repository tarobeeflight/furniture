import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
part 'display_quiz_map.g.dart';

@riverpod
class DisplayQuizMapNotifier extends _$DisplayQuizMapNotifier {
  @override
  Future<Map<String, Furniture>> build() async {
    final service = FirestoreService();
    final map = await service.fetchFurnitureMap(null);
    return map;
  }

  // TODO: ウィジェットに適用
  Future<void> fetchState(FurnitureQuery query) async {
    final service = FirestoreService();
    final map = await service.fetchFurnitureMap(query);
    state = AsyncValue.data(map);
  }
}