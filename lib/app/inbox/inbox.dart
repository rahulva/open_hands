import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/request/request_list_item.dart';
import 'package:open_hands/app/services/request_service.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../components/animation_components.dart';
import '../components/app_bar_part.dart';

class Inbox extends StatefulWidget {
  const Inbox({Key? key, required this.pageTitle}) : super(key: key);
  final String pageTitle;

  @override
  State<Inbox> createState() => InboxState();
}

class InboxState extends State<Inbox> with TickerProviderStateMixin {
  final AnimationStateHolder animationStateHolder = AnimationStateHolder();

  final ScrollController _scrollController = ScrollController();
  List<RequestData> requestList = List.empty();

  @override
  void initState() {
    animationStateHolder.initAnimationController(this);
    super.initState();
    getData().then((value) {
      setState(() {
        requestList = value;
      });
    });
  }

  Future<List<RequestData>> getData() async {
    return await RequestService.get().getMessagesForMe();
  }

  @override
  void dispose() {
    animationStateHolder.disposeAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.buildLightTheme(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI(context, widget.pageTitle),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: headerSilverBuilder,
                      body: Container(
                        color: AppTheme.buildLightTheme().colorScheme.background,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            requestList = await getData();
                          },
                          child: listViewBuilder(requestList, animationStateHolder),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> headerSilverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
          // return Column(
          //   children: <Widget>[
          //     /*getSearchBarUI(context),*/
          //     /*getTimeDateUI(),*/
          //   ],
          // );
        }, childCount: 1),
      ),
      // getFilterBarUI(context, 10),
    ];
  }

  ListView listViewBuilder(List<RequestData> requestList, animationStateHolder) {
    return ListView.builder(
      itemCount: requestList.length,
      padding: const EdgeInsets.only(top: 8),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        animationStateHolder.initAnimation(requestList.length, index);
        return RequestListItem(
          callback: () {},
          requestData: requestList[index],
          animationStateHolder: animationStateHolder,
        );
      },
    );
  }

// FIXME This is a cop
}
