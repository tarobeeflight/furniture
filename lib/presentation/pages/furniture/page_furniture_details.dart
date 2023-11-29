import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/theme/images.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';


@RoutePage()
class PageFurnitureDetails extends StatelessWidget {
  PageFurnitureDetails({super.key});

  final f = Furniture(
    enName: 'enName',
    jaName: 'jaName',
    designedYear: 1900,
    type: 'type',
    designer: Designer(
      enName: 'enName',
      jaName: 'jaName',
      country: 'country',
      culture: 'culture',
      birthday: DateTime(2000,10,10),
      faceUrl: 'faceUrl',
      memo: 'memo',
    ),
    brand: const Brand(
      enName: 'enName',
      jaName: 'jaName',
      country: 'country',
      foundedYear: 100,
      memo: 'memo',
    ),
    imageUrl: 'furniture/Arne Jacobsen/The Egg.jpg',
    memo: 'memo',
  );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(f.enName),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureImageL(url: f.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(f.jaName),
                IconButton(onPressed: (){}, icon: const Icon(Icons.description)),
              ],
            ),
            FurnitureDetailsText(f),

          ],
        ),
      ),
    );
  }
}