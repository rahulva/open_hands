import 'package:flutter/material.dart';
import 'package:open_hands/app/domain/post_data.dart';
import 'package:open_hands/app/domain/request_data.dart';
import 'package:open_hands/app/item_post/post_list_item.dart';
import 'package:open_hands/app/request/request_list_item.dart';
import 'package:open_hands/app/services/post_service.dart';
import 'package:open_hands/app/services/request_service.dart';
import 'package:open_hands/app/services/user_service.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../components/animation_components.dart';
import '../components/app_bar_part.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key, required this.pageTitle}) : super(key: key);
  final String pageTitle;

  @override
  State<MyPosts> createState() => MyPostsState();
}

class MyPostsState extends State<MyPosts> with TickerProviderStateMixin {
  final AnimationStateHolder animationStateHolder = AnimationStateHolder();
  final RequestService requestService = RequestService.get();
  final ScrollController scrollController = ScrollController();
  List<PostData> requestList = List.empty();

  @override
  void initState() {
    animationStateHolder.initAnimationController(this);
    super.initState();
    getData(widget.key.toString()).then((value) {
      setState(() {
        requestList = value;
      });
    });
  }

  Future<List<PostData>> getData(String from) async {
    var currentUser = UserService.get().loggedInUser?.email;
    return PostService.get().getPostCreatedBy(currentUser!);
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
                      controller: scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
        requestList = await getData(widget.key.toString());
      },
      child: ListView.builder(
        itemCount: requestList.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          animationStateHolder.initAnimation(requestList.length, index);
          return PostListItem(
            postData: requestList[index],
            animation: animationStateHolder.animation,
            animationController: animationStateHolder.animationController,
            callback: () {},
          );
        },
      ),
    );
  }
}
