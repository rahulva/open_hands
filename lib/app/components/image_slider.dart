import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/post_data.dart';

// FIXME image_input_widget is a copy of image_slider_widget and they are duplicate of this , should be refactored to remove duplicates.
Widget imageSlider({required PostData postData, required BuildContext context}) {
  // AuthenticationNotifer _auth =
  // Provider.of<AuthenticationNotifer>(context, listen: true);
  return SizedBox(
    height: MediaQuery.of(context).size.width - 50,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Swiper(
          itemCount: postData.images.length,
          pagination: const SwiperPagination(
            builder: SwiperPagination.dots,
          ),
          autoplay: false,
          itemBuilder: (BuildContext context, int index) {
            // return CachedNetworkImage(
            //   imageUrl: postData.images![index],
            //   imageBuilder: (context, imageProvider) => Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: imageProvider,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // );
            return Image.memory(base64Decode(postData.images[index].imageData));
          },
        ),
        Positioned(
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
        ),
      ],
    ),
  );
}
