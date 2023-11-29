import 'package:flutter/material.dart';
import 'package:furniture/domain/types/types.dart';
import 'package:furniture/presentation/widgets/my_widgets.dart';

class FurnitureListTile extends StatelessWidget {
  const FurnitureListTile({required this.furniture, required this.onTap, super.key,});

  final Furniture furniture;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final title = Text(furniture.jaName);
    final subtitle = Text("${furniture.designer.jaName}\n${furniture.brand.jaName}");
    final image = FutureImageS(url: furniture.imageUrl);

    return ListTile(
      isThreeLine: true,
      leading: image,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
    );
  }
}


