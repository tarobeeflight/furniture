import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/data/furniture_map.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/router/app_router.gr.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/presentation/widgets/image.dart';
import 'package:furniture/presentation/widgets/list_tile.dart';

@RoutePage()
class PageFurnitureList extends ConsumerWidget {
  const PageFurnitureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapAsyncValue = ref.watch(furnitureMapNotifierProvider);
    final map = mapAsyncValue.when<Map<String, Furniture>>(
      data: (d) => d,
      error: (_, e) => {},
      loading: () => {},
    );

    Widget display(Image image) {
      return Center(
        child: ImageL(image),
      );
    }

    final furnitureListTile = ListView.builder(
        itemCount: map.length,
        itemBuilder: (_, i) =>
            FurnitureListTile(
              furniture: map.values.elementAt(i),
              onTap: () {
                context.navigateTo(
                    RouteFurnitureDetails(
                      id: map.keys.elementAt(i),
                      furniture: map.values.elementAt(i),
                    )
                );
              },
            )
    );

    final body = switch(mapAsyncValue.isLoading) {
      true => display(Images.loading),
      false =>
      switch(mapAsyncValue.hasValue){
        true => furnitureListTile,
        false => display(Images.error),
      }
    };

    return Scaffold(
      body: body,
    );
  }
}