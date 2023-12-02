import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
part 'brand_map.g.dart';

@riverpod
class BrandMapNotifier extends _$BrandMapNotifier {
  @override
  Future<Map<String, Brand>> build() async {
    final service = FirestoreService();
    final map = await service.readBrandMap();
    return map;
  }

  Future<void> updateState() async {
    final service = FirestoreService();
    final map = await service.readBrandMap();
    state = AsyncValue.data(map);
  }
}