import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:furniture/application/state/data/display_furniture_map/display_furniture_map.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/router/app_router.gr.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/presentation/widgets/image.dart';
import 'package:furniture/presentation/widgets/list_tile.dart';
import 'package:furniture/presentation/widgets/side_menu.dart';

@RoutePage()
class PageFurnitureList extends ConsumerWidget {
  const PageFurnitureList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapAsyncValue = ref.watch(displayFurnitureMapNotifierProvider);
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

    final drawer = Drawer(
      child: SafeArea(  // OSのシステムバーに被らないようにする
        bottom: false,
        child: FurnitureSearchMenu()
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('家具一覧'),),
      body: body,
      endDrawer: drawer,
    );
  }
}