import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';

class FurnitureListTile extends StatelessWidget {
  const FurnitureListTile({required this.furniture, required this.image, super.key});

  final Furniture furniture;
  final Image image;
  // final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      isThreeLine: true,
      leading: ImageS(image),
      title: Text(furniture.jaName),
      subtitle: Text("${furniture.designer.jaName}\n${furniture.brand.jaName}"),
      // onTap: ,
    );
    return const Placeholder();
  }
}
