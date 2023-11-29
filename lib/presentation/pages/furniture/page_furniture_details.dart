import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';


@RoutePage()
class PageFurnitureDetails extends StatelessWidget {
  const PageFurnitureDetails({required this.furniture, super.key});

  final Furniture furniture;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text(furniture.jaName),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureImageL(url: furniture.imageUrl),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleText(furniture.enName),
                IconButton(onPressed: (){}, icon: const Icon(Icons.description)),
              ],
            ),
            FurnitureDetailsText(furniture),
          ],
        ),
      ),
    );
  }
}