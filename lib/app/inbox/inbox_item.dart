import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../common/constants.dart';
import '../components/animation_components.dart';

class InboxItem extends StatelessWidget {
  const InboxItem({Key? key, required this.requestData, this.animationStateHolder, this.callback})
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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
        },
        child: Container(
          decoration: BoxDecoration(
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
      borderRadius: const BorderRadius.all(Radius.circular(1.0)),
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
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'From: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.withOpacity(.78),
                                      ),
                                    ),
                                    Text(
                                      requestData.fromEmail,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        // color: Colors.grey.withOpacity(0.8),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Text(
                                      //   'at, ',
                                      //   textAlign: TextAlign.right,
                                      //   style: TextStyle(
                                      //     fontSize: 14,
                                      //     color: Colors.grey.withOpacity(0.8),
                                      //   ),
                                      // ),
                                      Text(
                                        appDateFormat.format(requestData.requestTime),
                                        textAlign: TextAlign.right,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),
                            Text(
                              requestData.messageText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                            const SizedBox(height: 8),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                meaningText('For post : '),
                                const SizedBox(
                                  width: 4,
                                ),
                                // Icon(
                                //   FontAwesomeIcons.locationDot,
                                //   size: 12,
                                //   color: AppTheme.buildLightTheme().primaryColor,
                                // ),
                                Expanded(
                                  child: Text(
                                    '${requestData.postId}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
                                  ),
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
          // favouriteIcon(),  // TODO Delete button could go here
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
            '500',
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

  Flexible meaningText(String test) {
    return Flexible(
      child: Text(
        test,
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.withOpacity(0.8),
        ),
        overflow: TextOverflow.visible,
      ),
    );

    // return Container(child: subText(),);
  }
}
