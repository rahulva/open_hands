import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/item_post/post_detail.dart';
import 'package:open_hands/app/theme/app_theme.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({
    Key? key,
    required this.postData,
    this.animationController,
    this.animation,
    this.callback,
  }) : super(key: key);

  final VoidCallback? callback;
  final PostData postData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostDetail(
                        postData: postData,
                        key: Key('${postData.id}'),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: buildClipRRect(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ClipRRect buildClipRRect() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              itemImage(postData),
              Container(
                color: AppTheme.buildLightTheme().colorScheme.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              mainText(),
                              subText(),
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.start,
                              //   children: <Widget>[
                              //     // meaningText(),
                              //     // const SizedBox(
                              //     //   width: 4,
                              //     // ),
                              //     Icon(
                              //       FontAwesomeIcons.locationDot,
                              //       size: 12,
                              //       color:
                              //           AppTheme.buildLightTheme().primaryColor,
                              //     ),
                              //     Expanded(
                              //       child: distanceText(),
                              //     ),
                              //   ],
                              // ),
                              // ratingAndAttemptWrapper(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // priceComponent(),
                  ],
                ),
              ),
            ],
          ),
          /*
          // Favorite Icon
          Positioned(
            top: 8,
            right: 8,
            child: Material(
              color: Colors.transparent,
              child: favoritIcon(),
            ),
          )*/
        ],
      ),
    );
  }

  InkWell favoritIcon() {
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(32.0),
      ),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.favorite_border,
          color: AppTheme.buildLightTheme().primaryColor,
        ),
      ),
    );
  }

  Padding ratingAndAttemptWrapper() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: <Widget>[
          /*ratingBar(),*/
          attemptText(),
        ],
      ),
    );
  }

  Padding priceComponent() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Text(
            // '\$${hotelData!.perNight}',
            '-',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          Text(
            '/per night',
            style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Text attemptText() {
    return Text(
      // ' ${postData!.failedAttempts} Attempts',
      ' ${postData.category} Attempts',
      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
    );
  }

  Text distanceText() {
    return Text(
      // '${postData!.dist.toStringAsFixed(1)} km to city',
      'Collection at ${postData.location}',
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
    );
  }

  Text mainText() {
    return Text(
      postData.title,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
    );
  }

  // Flexible meaningText() {
  //   return Flexible(
  //     child: subText(),
  //   );
  //
  //   // return Container(child: subText(),);
  // }

  Text subText() {
    return Text(
      // wordData!.meaning,
      postData.description,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.withOpacity(0.8),
      ),
      overflow: TextOverflow.visible,
    );
  }

  AspectRatio itemImage(PostData postData) {
    return AspectRatio(
      aspectRatio: 4,
      child: Image.memory(
        base64Decode(postData.images[0].imageData),
        fit: BoxFit.cover,
      ),
    );
  }

/*
  RatingBar ratingBar() {
    return RatingBar(
      initialRating: wordData!.difficultyLevel,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 24,
      ratingWidget: RatingWidget(
        full: Icon(
          Icons.star_rate_rounded,
          color: AppTheme.buildLightTheme().primaryColor,
        ),
        half: Icon(
          Icons.star_half_rounded,
          color: AppTheme.buildLightTheme().primaryColor,
        ),
        empty: Icon(
          Icons.star_border_rounded,
          color: AppTheme.buildLightTheme().primaryColor,
        ),
      ),
      itemPadding: EdgeInsets.zero,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }*/
}
