import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/request/request_list_item.dart';
import 'package:open_hands/app/services/request_service.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../components/animation_components.dart';
import '../components/filter_bar_part.dart';
import '../components/search_bar_component.dart';

class RequestList extends StatefulWidget {
  const RequestList({Key? key}) : super(key: key);

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> with TickerProviderStateMixin {
  final AnimationStateHolder animationStateHolder = AnimationStateHolder();
  final RequestService requestService = RequestService.get();
  final ScrollController _scrollController = ScrollController();
  List<RequestData> requestList = List.empty();

  @override
  void initState() {
    animationStateHolder.initAnimationController(this);
    super.initState();
    requestService.getRequestsByMe().then((value) {
      setState(() {
        requestList = value;
      });
    });
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
                  getAppBarUI(context),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                              return SizedBox(height: 20,);
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
                      },
                      body: Container(
                        color: AppTheme.buildLightTheme().colorScheme.background,
                        child: defaultListView(),
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

  Widget defaultListView() {
    return RefreshIndicator(
        onRefresh: () async {
          requestList = await requestService.getRequestsByMe();
        },
        child: ListView.builder(
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
        ));
  }

  Widget getAppBarUI(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().colorScheme.background,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, 2), blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            appBarBackButtonContainer(context),
            appBarTitleContainer(),
            appBarLocationFavContainer(context)
          ],
        ),
      ),
    );
  }

  Container appBarBackButtonContainer(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: AppBar().preferredSize.height + 40,
      height: AppBar().preferredSize.height,
      child: const Material(
        color: Colors.transparent,
/*                child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back),
                ),
              ),*/
      ),
    );
  }

  Expanded appBarTitleContainer() {
    return const Expanded(
      child: Center(
        child: Text('My Requests', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22)),
      ),
    );
  }

  SizedBox appBarLocationFavContainer(BuildContext context) {
    return SizedBox(
      width: AppBar().preferredSize.height + 40,
      height: AppBar().preferredSize.height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[favoriteButton(context), locationButton(context)],
      ),
    );
  }

  Material favoriteButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.favorite_border)),
        onTap: () {},
      ),
    );
  }

  Material locationButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(FontAwesomeIcons.locationDot)),
        onTap: () {},
      ),
    );
  }
}

/*class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}*/
