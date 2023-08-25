import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/theme/app_theme.dart';
import '../components/animation_components.dart';

class RequestListItem extends StatelessWidget {
  const RequestListItem({Key? key, required this.requestData, this.animationStateHolder, this.callback})
      : super(key: key);

  final AnimationStateHolder? animationStateHolder;
  final VoidCallback? callback;
  final RequestData requestData;

  @override
  Widget build(BuildContext context) {
    return animationWrapper(
      coreComponent(),
      animationStateHolder?.animationController,
      animationStateHolder?.animation,
    );
  }

  Padding coreComponent() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          // FIXME navigation to detail view
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PostDetail(
          //       requestData: requestData,
          //       key: Key('${requestData.id}'),
          //     ),
          //   ),
          // );

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
    );
  }

  ClipRRect buildClipRRect() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                color: AppTheme.buildLightTheme().colorScheme.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            mainText('To ${requestData.toEmail}'),
                            subText(requestData.messageText),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                meaningText(),
                                // const SizedBox(
                                //   width: 4,
                                // ),
                                Icon(
                                  FontAwesomeIcons.locationDot,
                                  size: 12,
                                  color: AppTheme.buildLightTheme().primaryColor,
                                ),
                                Expanded(
                                  child: distanceText('On ${requestData.requestTime}'),
                                ),
                              ],
                            ),
                            // ratingAndAttemptWrapper(),
                          ],
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
          favouriteIcon(),
          */
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

/*  Text attemptText() {
    return ;
  }*/

  Text distanceText(String location) {
    return Text(
      // '${requestData!.dist.toStringAsFixed(1)} km to city',
      // 'Collection at ${requestData.location}',
      location,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
    );
  }

  Text mainText(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
      ),
    );
  }

  Flexible meaningText() {
    return Flexible(
      child: subText("Test"),
    );

    // return Container(child: subText(),);
  }

  Text subText(String text) {
    return Text(
      // wordData!.meaning,
      text,
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey.withOpacity(0.8),
      ),
      overflow: TextOverflow.visible,
    );
  }
}
