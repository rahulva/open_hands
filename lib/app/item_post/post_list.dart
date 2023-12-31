import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_hands/app/item_post/post_list_item.dart';
import 'package:open_hands/app/services/post_service.dart';
import 'package:open_hands/app/theme/app_theme.dart';

import '../components/search_bar_component.dart';
import '../domain/post_data.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key, required this.pageTitle}) : super(key: key);
  final String pageTitle;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> with TickerProviderStateMixin {
  AnimationController? animationController;
  PostService postService = PostService.get();
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  List<PostData> posts = List.empty();

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);

    super.initState();
    getDataFor(widget.pageTitle).then((value) {
      setState(() {
        posts = value;
      });
    });
  }

  Future<List<PostData>> getDataFor(String page) async {
    return PostService.get().getAllPosts();
  }

  Future<List<PostData>> searchData(String searchTerm) async {
    return PostService.get().search(searchTerm);
  }

  @override
  void dispose() {
    animationController?.dispose();
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
                  getAppBarUI(),
                  Expanded(
                    child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverList(
                            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  getSearchBarUI(context, 'Search term...', (String searchTerm) async {
                                    List<PostData> results = await searchData(searchTerm);
                                    setState(() {
                                      posts = results;
                                    });
                                  }),
                                  /*getTimeDateUI(),*/
                                ],
                              );
                            }, childCount: 1),
                          ),
                          /*SliverPersistentHeader(
                            pinned: true,
                            floating: true,
                            delegate: ContestTabHeader(
                              getFilterBarUI(),
                            ),
                          ),*/
                        ];
                      },
                      body: Container(
                        color: AppTheme.buildLightTheme().colorScheme.background,
                        child:
                        defaultListView(),
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
        posts = await getDataFor(widget.pageTitle);
      },
      child: posts.isEmpty
          ? const Center(child: Text('No posts available'))
          : ListView.builder(
              itemCount: posts.length,
              padding: const EdgeInsets.only(top: 8),
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var length2 = posts.length;
                final int count = length2 > 10 ? 10 : length2;
                var interval = Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn);
                var curvedAnimation = CurvedAnimation(parent: animationController!, curve: interval);
                final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
                animationController?.forward();

                return PostListItem(
                  callback: () {},
                  postData: posts[index],
                  animation: animation,
                  animationController: animationController!,
                );
              },
            ),
    );
  }

  Widget getAppBarUI() {
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
          children: <Widget>[appBarBackButtonContainer(), appBarTitleContainer(), appBarLocationFavContainer()],
        ),
      ),
    );
  }

  Container appBarBackButtonContainer() {
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
      child: Center(child: Text('Posts', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22))),
    );
  }

  SizedBox appBarLocationFavContainer() {
    return SizedBox(
      width: AppBar().preferredSize.height + 40,
      height: AppBar().preferredSize.height,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          /*favoriteButton(), locationButton()*/
        ],
      ),
    );
  }

  Material favoriteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(Icons.favorite_border)),
        onTap: () {},
      ),
    );
  }

  Material locationButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
        child: const Padding(padding: EdgeInsets.all(8.0), child: Icon(FontAwesomeIcons.locationDot)),
        onTap: () {},
      ),
    );
  }

/*
  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, -2), blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return listView();
                }
              },
            ),
          )
        ],
      ),
    );
  }*/

/*  ListView listView2() {
    return ListView.builder(
      itemCount: posts.length,

      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        var length2 = posts.length;
        final int count = length2 > 10 ? 10 : length2;
        var interval = Interval((1 / count) * index, 1.0, curve: Curves.fastOutSlowIn);
        var curvedAnimation = CurvedAnimation(parent: animationController!, curve: interval);
        final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);
        animationController?.forward();

        return PostListItemView(
          callback: () {},
          postData: posts[index],
          animation: animation,
          animationController: animationController!,
        );
      },
    );
  }*/

/*
// Tempd disable
  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16, color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100, fontSize: 16, color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

 */

/*
// Temp Disabled
  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: AppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(color: Colors.grey.withOpacity(0.2), offset: const Offset(0, -2), blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: AppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${postService.getDummyPosts().length} Words',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(), fullscreenDialog: true),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort, color: AppTheme.buildLightTheme().primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
 */
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
