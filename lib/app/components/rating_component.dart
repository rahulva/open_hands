import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../theme/app_theme.dart';

Padding ratingAndAttemptWrapper(String text, double initialRating, Function(double) onRatingUpdate) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Row(
      children: <Widget>[
        _ratingBar(initialRating, onRatingUpdate),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
        ),
      ],
    ),
  );
}

RatingBar _ratingBar(double initialRating, Function(double) updateCallback) {
  return RatingBar(
    initialRating: initialRating,
    direction: Axis.horizontal,
    allowHalfRating: true,
    itemCount: 5,
    itemSize: 24,
    ratingWidget: RatingWidget(
      full: Icon(Icons.star_rate_rounded, color: AppTheme.buildLightTheme().primaryColor),
      half: Icon(Icons.star_half_rounded, color: AppTheme.buildLightTheme().primaryColor),
      empty: Icon(Icons.star_border_rounded, color: AppTheme.buildLightTheme().primaryColor),
    ),
    itemPadding: EdgeInsets.zero,
    onRatingUpdate: updateCallback,
  );
}
