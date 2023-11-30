import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/domain/types/types.dart';

part 'furniture_list.g.dart';



@riverpod
class FurnitureListNotifier extends _$FurnitureListNotifier {
  @override
  Future<List<Furniture>> build() async {
    final service = FirestoreService();
    final list = await service.fetchFurniture(null);

    return list;
  }
}