import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/domain/types/db_query/db_query.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/infrastructure/firebase/firestore_service.dart';
import 'package:furniture/infrastructure/firebase/storage_service.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/presentation/widgets/image.dart';

@RoutePage()
class PageFurnitureList extends StatelessWidget {
  const PageFurnitureList({super.key});

  @override
  Widget build(BuildContext context) {
    const query = DbQuery(
      collection: Collection.furniture,
      property: FurnitureField.all,
      targets: [],
      limit: 30
    );
    final firestore = FirestoreService();
    final fList =
      // await firestore.readFurnitureList(query);  // build内でawait使えない → ステイトにする？
      firestore.testGetFurnitureList();
    final storage = StorageService();
    List<Image> images = [];
    for(Furniture f in fList) {
      final image =
          // await storage.getImage(f.imageUrl);
          // Images.sunsets;   // build内でawait使えない → ステイトにする？
          Image.network('src');
      images.add(image);
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: fList.length,
        itemBuilder: (_, i) {
          return ListTile(
            isThreeLine: true,
            leading: ImageS(images.elementAt(i)),
            title: Text(fList.elementAt(i).jaName),
            subtitle: Text("${fList.elementAt(i).designer.jaName}\n${fList.elementAt(i).brand.jaName}"),
          );
        }
      ),
    );
  }
}
