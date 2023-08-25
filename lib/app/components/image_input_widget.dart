import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_hands/app/camera/image_collector.dart';
import 'package:path_provider/path_provider.dart';

class ImageInputWidget extends StatefulWidget {
  final ImageCollector imageCollector = ImageCollector();
  final bool fromInternet;
  final bool showFavourite;

  ImageInputWidget({super.key, this.showFavourite = false, this.fromInternet = false});

  @override
  State<ImageInputWidget> createState() {
    return _StatefulWidgetState();
  }
}

class _StatefulWidgetState extends State<ImageInputWidget> {
  List<String> images = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      camActionButton(),
      SizedBox(
        // height: MediaQuery.of(context).size.width - 50,
        height: 240,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            buildSwiper(images, widget.fromInternet ? 'internet' : 'file_system'),
            widget.showFavourite ? favouriteIcon() : Positioned(child: Container()),
          ],
        ),
      )
    ]);
  }

  FloatingActionButton camActionButton() {
    return FloatingActionButton(
      child: const Icon(Icons.camera_alt),
      onPressed: () async {
        var newImage = await pickImage();
        if (newImage != null) {
          Directory directory = await getApplicationDocumentsDirectory();
          String path = '${directory.path}/post_image${Random(10).nextInt(10)}.png';
          File nf = File(newImage.path);
          var file = await nf.copy(path);
          widget.imageCollector.add = file.path;

          setState(() {
            images = List.of(widget.imageCollector.images);
          });
          // imgWidget.imageURIs.add(s);
        }
      },
    );
  }

  Future<XFile?> pickImage() async {
    try {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file == null) {
        return null;
      }
      return file;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Failed to pick image: $e');
      }
    }
    return null;
  }

  Swiper buildSwiper(List<String> images, String source) {
    return Swiper(
      itemCount: images.length,
      pagination: const SwiperPagination(
        builder: SwiperPagination.dots,
      ),
      autoplay: false,
      itemBuilder: (BuildContext context, int index) {
        switch (source) {
          case 'internet':
            return networkImage(index);
          case 'file_system':
            return localImage(index);
          case 'memory':
            return Image.memory(base64Decode(""));
        }
        return const Icon(Icons.error);
      },
    );
  }

  Widget localImage(int index) {
    return Image.file(
      File(images[index]),
      fit: BoxFit.cover,
      errorBuilder: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget networkImage(int index) {
    return CachedNetworkImage(
      imageUrl: images[index],
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Positioned favouriteIcon() {
    return Positioned(
      right: 10,
      bottom: -20,
      child: InkWell(
        onTap: () async {
/*              var data =
            await Provider.of<FavouriteNotifier>(context, listen: false);
            bool isAdded = await data.addToFavourite(
              userId: _auth.userId!,
              room_id: roomModel.roomId,
            );*/
/*              if (isAdded) {
              SnackUtil.showSnackBar(
                context: context,
                text: 'Added To Favourite',
                textColor: AppColors.creamColor,
                backgroundColor: Colors.red.shade200,
              );
            } else {
              SnackUtil.showSnackBar(
                context: context,
                text: data.error!,
                textColor: AppColors.creamColor,
                backgroundColor: Colors.red.shade200,
              );
            }*/
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.pink.shade400,
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
