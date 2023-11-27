import 'dart:math';

class RandomUsecase {
  List<int> getRandomNumList(int length) {
    /// 大きさ確認
    if(length < 0) {
      return [];
    }

    /// 順番通りの数列を作成
    final list = List.generate(length, (index) => index);

    /// 要素をランダムに入れ替えることを繰り返す
    for (int i = 0; i < list.length; i++){
      final random = Random();
      final newIndex = random.nextInt(length - 1);
      final buff = list[newIndex];
      list[newIndex] = list[i];
      list[i] = buff;
    }

    return list;
  }
}