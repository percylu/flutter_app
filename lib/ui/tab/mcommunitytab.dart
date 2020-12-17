import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/entity/pet_entity.dart';
import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/ui/friendsns.dart';
import 'package:flutter_app/utility/Config.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../draws.dart';
import '../home.dart';
import '../miaodetail.dart';

class CommunityMain extends StatefulWidget {
  @override
  _CommunityMainTabView createState() => _CommunityMainTabView();
}

class _CommunityMainTabView extends State<CommunityMain>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  var listFlag;
  TabController tabController;
  TextEditingController searchController;
  var _isSearch = false;

  /***************************下拉刷新，上拉家在**************************************/
  // 用一个key来保存下拉刷新控件RefreshIndicator
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  // 承载listView的滚动视图
  ScrollController _scrollController = ScrollController();

  // 数据源
  List<String> _dataSource = List<String>();

  // 当前加载的页数
  int _pageSize = 0;

  // 加载数据
  void _loadData(int index) {
    for (int i = 0; i < 15; i++) {
      _dataSource.add((i + 15 * index).toString());
    }
  }

  // 下拉刷新
  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      print("正在刷新...");
      _pageSize = 0;
      _dataSource.clear();
      setState(() {
        _loadData(_pageSize);
      });
    });
  }

  // 加载更多
  Future<Null> _loadMoreData() {
    return Future.delayed(Duration(seconds: 1), () {
      print("正在加载更多...");

      setState(() {
        _pageSize++;
        _loadData(_pageSize);
      });
    });
  }

  // 刷新
  showRefreshLoading() {
    new Future.delayed(const Duration(seconds: 2), () {
      _refreshKey.currentState.show().then((e) {});
      return true;
    });
  }

  @override
  void initState() {
    /***************************8下拉刷新，上拉家在**************************************/
    showRefreshLoading();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    /***************************8下拉刷新，上拉家在**************************************/
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 250, height: 445, allowFontScaling: true);
    return Theme(
        data: ThemeData(
          primaryColor: Colors.white,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: Drawers(),
            appBar: AppBar(
                elevation: 0.8,
                leading: Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                      size: ScreenUtil().setWidth(18),
                    ),
                    onPressed: () async {
                      _isSearch = !_isSearch;
                      setState(() {});
                    },
                  ),
                ),
                actions: [
                  FlatButton(
                      child: Text(
                        "喵",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: ScreenUtil().setSp(13.33)),
                      ),
                      onPressed: () {
                        //Navigator.pop(context);
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (_) {
                          return new HomePage(index: 2);
                        }));
                      }),
                ],
                title: _isSearch
                    ? TextField(
                        controller: searchController,
                      )
                    : TabBar(
                        indicator: const BoxDecoration(),
                        labelStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(11),
                          fontWeight: FontWeight.w600,
                        ),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(text: "广场"),
                          Tab(text: "同城"),
                          Tab(text: "关注  "),
                        ],
                        controller: tabController,
                      )),
            body: _isSearch
                ? Center(child: Text("功能开发中"))
                : TabBarView(
                    children: [
                      Center(
                        child: _builderContent(0),
                      ),
                      Center(
                        child: _builderContent(1),
                      ),
                      Center(
                        child: _builderContent(2),
                      ),
                    ],
                    controller: tabController,
                  )));
  }

  initData() async {
    tabController = TabController(length: 3, vsync: this);

    setState(() {});
  }

  Widget _builderContent(int Index) {
    return Container(
      margin: EdgeInsets.only(
          top: ScreenUtil().setHeight(15),
          left: ScreenUtil().setWidth(18.67),
          right: ScreenUtil().setWidth(18.67)),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black, width: 2),
              borderRadius: BorderRadiusDirectional.circular(20),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2020谁是萌猫得主",
                        style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: ScreenUtil().setSp(10),
                            fontWeight: FontWeight.w600)),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(5),
                          bottom: ScreenUtil().setHeight(5)),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "热门话题hot~",
                        style: TextStyle(color: Color(0xFF9A9A9A)),
                      ),
                    ),
                    FlatButton(
                        color: Colors.grey,
                        child: Container(
                          color: Colors.grey,
                          child: Text(
                            "GET话题",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black12, width: 1.5),
                            borderRadius: BorderRadiusDirectional.circular(20)),
                        onPressed: () {})
                  ],
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(15),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(20)),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1602999654675&di=4da7e075524f92096b3bbaf0f18009c4&imgtype=0&src=http%3A%2F%2Fimg.go007.com%2F2017%2F06%2F18%2Fa51996bbe2610044_1.jpg",
                    width: ScreenUtil().setWidth(80.34),
                    height: ScreenUtil().setWidth(80.34),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(12),
                bottom: ScreenUtil().setHeight(5)),
            padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
            height: 1,
            color: Color(0xFFEDEDED),
          ),
          Container(
            // padding: EdgeInsets.only(left:ScreenUtil().setWidth(10),right:ScreenUtil().setWidth(10)),
            height: ScreenUtil().setHeight(250),
            child: RefreshIndicator(
              key: _refreshKey,
              onRefresh: _onRefresh,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 2,
                    //纵轴间距
                    mainAxisSpacing: 10.0,
                    //横轴间距
                    crossAxisSpacing: 10.0,
                    //子组件宽高长度比例
                    childAspectRatio: 0.6),
                controller: _scrollController,
                //padding: EdgeInsets.all(8.0),
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (buildContext, index) {
                  return items(context, index);
                },
                itemCount: _dataSource.isEmpty ? 0 : _dataSource.length + 1,
              ),
            ),
          )
        ],
      ),
    );
  }

// item控件
  Widget items(context, index) {
    if (index == _dataSource.length) {
      return Container(
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "正在加载",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black),
                  )
                ],
              ),
            )),
      );
    }
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (_)
                {
                  return new FriendSns();
                }));
              },
              child: Container(
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey.shade50, //边框颜色
                    width: 1, //边框宽度
                  ), // 边色与边宽度
                  color: Colors.white, // 底色
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, //阴影范围
                      spreadRadius: 1, //阴影浓度
                      color: Colors.grey.shade200, //阴影颜色
                    ),
                  ],
                  borderRadius: BorderRadius.circular(5), // 圆角也可控件一边圆角大小
                  //borderRadius: BorderRadius.only(
                  //  topRight: Radius.circular(10),
                  // bottomRight: Radius.circular(10)) //单独加某一边圆角
                ),
                child: Column(
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                          imageUrl:
                              "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
                          height: ScreenUtil().setHeight(90),
                          fit: BoxFit.cover),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Center(
                        child: Text("爱会消失对不对( p′︵‵。)",
                            style: TextStyle(fontSize: ScreenUtil().setSp(7)))),
                    SizedBox(
                      height: ScreenUtil().setHeight(5),
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("二哈",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(7),
                                color: Colors.black38)),
                        SizedBox(
                          width: ScreenUtil().setWidth(10),
                        ),
                        Image.asset(
                          "assets/ic_hot.png",
                          width: ScreenUtil().setWidth(5.34),
                          height: ScreenUtil().setHeight(6.67),
                        ),
                        Text("100",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(7),
                                color: Colors.black38))
                      ],
                    )),
                  ],
                ),
              ),
            )));
  }

  _showError(String title, String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: title,
            message: msg,
            negativeText: "返回",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );
        });
  }
}
