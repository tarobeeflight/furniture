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
}