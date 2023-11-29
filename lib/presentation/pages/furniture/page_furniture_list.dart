import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/presentation/widgets/image.dart';
import 'package:furniture/presentation/widgets/list_tile.dart';

@RoutePage()
class PageFurnitureList extends StatefulWidget {
  const PageFurnitureList({super.key});

  @override
  State<PageFurnitureList> createState() => _PageFurnitureListState();
}

class _PageFurnitureListState extends State<PageFurnitureList> {

  late Future<List<Furniture>> list;

  @override
  void initState() {
    super.initState();

    /// 家具一覧を取得
    final service = FirestoreService();
    list = service.fetchFurniture(null);
  }

  @override
  Widget build(BuildContext context) {

    Widget display(Image image){
      return Center(
        child: ImageL(image),
      );
    }

    final body = FutureBuilder(
        future: list,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return display(Images.error);
            case ConnectionState.waiting:
              return display(Images.loading);
            case ConnectionState.done:
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, i) => FurnitureListTile(furniture: snapshot.data!.elementAt(i))
              );
            case ConnectionState.active:
              return display(Images.sunsets);
          }
        }
    );

    return Scaffold(
      body: body,
    );
  }
}
