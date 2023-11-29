import 'package:flutter/material.dart';
import 'package:furniture/infrastructure/firebase/storage_service.dart';
import 'package:furniture/presentation/theme/images.dart';


class ImageL extends StatelessWidget {
  ImageL(this.image, {super.key});

  Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: image,
    );
  }
}

class ImageS extends StatelessWidget {
  ImageS(this.image, {super.key});

  Image image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: image,
    );
  }
}

class FutureImageS extends StatefulWidget {
  const FutureImageS({required this.url, super.key});

  final String url;

  @override
  State<FutureImageS> createState() => _FutureImageSState();
}

class _FutureImageSState extends State<FutureImageS> {

  late Future<Image> image;

  @override
  void initState(){
    super.initState();
    final url = widget.url;
    final usecase = StorageService();
    image = usecase.getImage(url);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: image,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return ImageS(Images.error);
          case ConnectionState.waiting:
            return ImageS(Images.loading);
          case ConnectionState.done:
            return ImageS(snapshot.data!);
          case ConnectionState.active:
            return ImageS(Images.sunsets);
        }
      },
    );
  }
}

class FutureImageL extends StatefulWidget {
  const FutureImageL({required this.url, super.key});

  final String url;

  @override
  State<FutureImageL> createState() => _FutureImageLState();
}

class _FutureImageLState extends State<FutureImageL> {

  late Future<Image> image;

  @override
  void initState(){
    super.initState();
    final url = widget.url;
    final usecase = StorageService();
    image = usecase.getImage(url);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: image,
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
            return ImageL(Images.error);
          case ConnectionState.waiting:
            return ImageL(Images.loading);
          case ConnectionState.done:
            return ImageL(snapshot.data!);
          case ConnectionState.active:
            return ImageL(Images.sunsets);
        }
      },
    );
  }
}



