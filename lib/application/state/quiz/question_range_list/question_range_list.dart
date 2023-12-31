import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/pages/quiz/page_quiz_setting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'question_range_list.g.dart';


@riverpod
class QuestionRangeListNotifier extends _$QuestionRangeListNotifier {
  @override
  Future<List<String>> build() async {
    return ['loading'];
  }

  void resetState() {
    state = const AsyncValue.data([]);
  }

  void updateState(GENRE genre) async {

    Future<List<String>> getDesigners() async {
      final service = FirestoreService();
      final dList = await service.fetchDesignerCollection();
      final list = dList.map((e) => e.jaName).toList();
      return list;
    }

    Future<List<String>> getBrands() async {
      final service = FirestoreService();
      final dList = await service.fetchBrandCollection();
      final list = dList.map((e) => e.jaName).toList();
      return list;
    }

    List<String> getCultures() {
      return CULTURE.values.map((e) => e.toString()).toList();
    }

    final list = switch(genre) {
      GENRE.all => ['null'],
      GENRE.culture => getCultures(),
      GENRE.designer => await getDesigners(),
      GENRE.brand => await getBrands(),
    };
    state = AsyncValue.data(list);
  }
}