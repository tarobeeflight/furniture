import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
part 'designer_map.g.dart';

@riverpod
class DesignerMapNotifier extends _$DesignerMapNotifier {
  @override
  Future<Map<String, Designer>> build() async {
    final service = FirestoreService();
    final map = await service.readDesignerMap();
    return map;
  }

  Future<void> updateState() async {
    final service = FirestoreService();
    final map = await service.readDesignerMap();
    state = AsyncValue.data(map);
  }
}