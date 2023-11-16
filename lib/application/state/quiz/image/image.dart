import 'package:flutter/material.dart';
import 'package:furniture/infrastructure/firebase/storage_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:furniture/presentation/theme/images.dart';
part 'image.g.dart';

@riverpod
class ImageNotifier extends _$ImageNotifier {

  @override
  Future<Image> build() async {
    return Images.sunsets;
  }

  Future<void> updateState(String path) async {
    state = const AsyncValue.loading();

    // 画像を取得
    final service = StorageService();
    final image = await service.getImage(path);

    // データを上書き
    state = AsyncValue.data(image);
  }
}