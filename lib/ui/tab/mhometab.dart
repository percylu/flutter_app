import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
/**
 * Author: Damodar Lohani
 * profile: https://github.com/lohanidamodar
 */

import 'package:flutter/material.dart';
import 'package:flutter_app/api/MiaoApi.dart';
import 'package:flutter_app/model/product_bean.dart';
import 'package:flutter_app/utility/ResultData.dart';
import 'package:flutter_app/utility/SpUtils.dart';
import 'package:flutter_app/widget/messagedialog.dart';
import 'package:flutter_app/widget/newWidgets.dart';
import 'package:flutter_app/widget/picandpicbutton.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../draws.dart';

class MiaoHomeTabView extends StatefulWidget {
  MiaoHomeTabView({Key key}) : super(key: key);

  @override
  State createState() {
    return _MiaoHomeTabView();
  }
}

class _MiaoHomeTabView extends State<MiaoHomeTabView>
    with SingleTickerProviderStateMixin {
  var isRefresh = false;
  List swiperDataList = [];
  List urlList = [];
  var url = "";
  var iosUrl = "";
  var promotionTitle = "新一代智能猫砂盘";
  var promotionPrice = "0.00";
  var promotionNewPrice = "0.00";
  var promotionUrl = "";
  bool nomore = false;

  /***************************下拉刷新，上拉家在**************************************/
  // 用一个key来保存下拉刷新控件RefreshIndicator
  GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  // 承载listView的滚动视图
  ScrollController _scrollController = ScrollController();

  // 数据源
  List<Rows> _dataSource = List<Rows>();

  // 当前加载的页数
  int _pageSize = 1;

  // 加载数据
  void _loadData(int index) async {
    ResultData res = await MiaoApi.productQueryListPage(index);
    List<Rows> rows = ProductBean.fromJson(res.data).data.rows;
    if (rows.isEmpty) {
      nomore = true;
    } else {
      nomore = false;
      _dataSource.addAll(rows);
    }
    setState(() {});
    // for (int i = 0; i < 15; i++) {
    //   _dataSource.add((i + 15 * index).toString());
    // }
  }

  // 下拉刷新
  Future<Null> _onRefresh() {
    return Future.delayed(Duration(seconds: 2), () {
      print("正在刷新...");
      _pageSize = 1;
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
    super.initState();
    _pageSize=1;
    //_futureBuilderFuture = initData(context);
    var context = this.context;
    /***************************8下拉刷新，上拉家在**************************************/
    showRefreshLoading();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
    /***************************8下拉刷新，上拉家在**************************************/
    initData(context);
  }

  initData(BuildContext context) async {
    // ResultData res = await MiaoApi.getArticle();
    // if (res.code == 200) {
    //   _imgurl = SpUtils.URL + res.data['data']['articleCover'];
    //   _desc = res.data['data']['articleTitle'];
    //   _content = res.data['data']['articleContent'];
    // }

    //  if (!this.isRefresh) {
    ResultData resa = await MiaoApi.banner(); //.then((res) {
    print("--initData-");

    ResultData response = resa;
    if (response.code == 200) {
      List list = [];
      urlList.clear();
      for (var banner in response.data['data']) {
        list.add(SpUtils.URL + banner['bannerImg']);
        urlList.add(banner['bannerUrl']);
      }
//          setState(() {
      this.isRefresh = true;
      this.swiperDataList = list;
//          });
    } else {
      if (response.code == 1502) {
        Navigator.pushReplacementNamed(context, "home");
      }
      _showError(context, response.message);
    }

    ResultData ress = await MiaoApi.productDetail();

    if (ress.code == 200) {
      promotionUrl = SpUtils.URL + ress.data['data']['img'];
      print(promotionUrl);
      promotionPrice = ress.data['data']['originalPrice'].toString();
      promotionTitle = ress.data['data']['name'];
      promotionNewPrice = ress.data['data']['salePrice'].toString();
      url = ress.data['data']['link'];
      iosUrl = ress.data['data']['link'];
    }

    // });
    //  }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    ScreenUtil.init(width: 250, height: 445);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scaffold(
            backgroundColor: Colors.white,
            drawer: Drawers(),
            body: ListView(
              children: <Widget>[
                this.swiperDataList.length > 0
                    ? _banner(context)
                    : Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: ScreenUtil().setHeight(150),
                        child: Text("加载中..."),
                      ),
                _buildCategoryRow(context),
                Container(
                  height: 1,
                  color: Colors.grey.shade200,
                  margin: EdgeInsets.only(
                      left: ScreenUtil().setWidth(25),
                      right: ScreenUtil().setWidth(25)),
                ),
                _buildCenterPic(context)
              ],
            )));
  }

  _showError(BuildContext context, String msg) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new MessageDialog(
            title: "请先登陆",
            message: msg,
            negativeText: "返回登陆",
            onCloseEvent: () {
              Navigator.pop(context);
            },
            onConfirmEvent: () {
              Navigator.pop(context);
            },
          );
        });
  }

  Widget _buildCategoryRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: ScreenUtil().setHeight(68),
      child: Row(
        children: <Widget>[
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_first@3x.png", "assets/words_msp@3x.png", () {
              Navigator.pushNamed(context, "devicelist");
            }),
          ),
          Container(
            width: 1,
            height: ScreenUtil().setHeight(40),
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_second@3x.png", "assets/words_ysj@3x.png", () {
              //Navigator.pushNamed(context, "comming");
              Navigator.pushNamed(context, "devicelist");
            }),
          ),
          Container(
            width: 1,
            height: ScreenUtil().setHeight(40),
            color: Colors.grey.shade300,
          ),
          Expanded(
            child: picAndPicButton(
                "assets/btn_mxx_third@3x.png", "assets/words_wsq@3x.png", () {
              //Navigator.pushNamed(context, "comming");
              Navigator.pushNamed(context, "devicelist");
            }),
          ),
        ],
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(150),
        child: Stack(
          children: [
            Swiper(
              outer: false,
              //autoplayDelay: 2000,
              autoplay: false,
              itemBuilder: (c, i) {
                return //swiperDataList.length>0?
                    GestureDetector(
                        child: CachedNetworkImage(
                          imageUrl: "${swiperDataList[i]}",
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                        onTap: () async {
                          if (urlList[i].toString().substring(0,4)=="http" ) {
                            print(urlList[i]);
                            await launch(urlList[i]);
                            //网址
                          } else {
                            //文章ID
                            ResultData res =
                                await MiaoApi.getArticle(urlList[i]);
                            if (res.code == 200) {
                              var _content = res.data['data']['articleContent'];
                              //NewsHtml(_content);
                              Navigator.of(context)
                                  .push(new MaterialPageRoute(builder: (_) {
                                return new NewsHtml(content: _content);
                              }));
                            }
                          }
                        }
                        //:Text("加载中...");
                        );
              },
              pagination: new SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.all(0),
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white,
                    activeColor: Colors.deepOrangeAccent.shade200,
                  )),
              itemCount: swiperDataList.length,
            ),
            Container(
                margin: EdgeInsets.only(
                    top: 30, left: MediaQuery.of(context).size.width - 80),
                child: RaisedButton(
                  padding: EdgeInsets.all(3.0),
                  color: Colors.white,
                  shape: CircleBorder(side: BorderSide(color: Colors.white)),
                  child: Image.asset(
                    "assets/ic_miao.png",
                    scale: 1.8,
                  ),
                  onPressed: () {},
                )),
          ],
        ));
  }

  Widget _product() {
    return Container(
      // padding: EdgeInsets.only(left:ScreenUtil().setWidth(10),right:ScreenUtil().setWidth(10)),
      height: ScreenUtil().setHeight(150),
      child: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _onRefresh,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 2,
              //纵轴间距
              mainAxisSpacing: 20.0,
              //横轴间距
              crossAxisSpacing: 20.0,
              //子组件宽高长度比例
              // childAspectRatio: 0.65
              childAspectRatio: 0.68),
          controller: _scrollController,
          //padding: EdgeInsets.all(8.0),
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (buildContext, index) {
            return items(context, index);
          },
          itemCount: _dataSource.isEmpty ? 0 : _dataSource.length + 1,
        ),
      ),
    );
  }

// item控件
  Widget items(context, index) {
    if (index == _dataSource.length) {
      return Container(
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  nomore||_dataSource.length==1
                      ? Container()
                      : CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                        ),
                  nomore||_dataSource.length==1
                      ? Container()
                      : SizedBox(
                          width: 10.0,
                        ),
                  Text(
                    nomore ||_dataSource.length==1? "没有更多了" : "正在加载",
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
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () async {
                if (await canLaunch(_dataSource[index].link)) {
                  await launch(_dataSource[index].link);
                } else if (await canLaunch(_dataSource[index].link)) {
                  await launch(_dataSource[index].link);
                } else {
                  throw "不可以打开App";
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: new Border.all(
                    color: Colors.grey.shade50, //边框颜色
                    width: 1,

                    //边框宽度
                  ), // 边色与边宽度
                  color: Colors.white, // 底色
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2, //阴影范围
                      spreadRadius: 1, //阴影浓度
                      color: Colors.grey.shade200, //阴影颜色
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20), // 圆角也可控件一边圆角大小
                  //borderRadius: BorderRadius.only(
                  //  topRight: Radius.circular(10),
                  // bottomRight: Radius.circular(10)) //单独加某一边圆角
                ),
                child: Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide.none,
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                          imageUrl: SpUtils.URL + _dataSource[index].img,
                          //"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1603096933847&di=e23a77b32d65228a9722e796863e7e3a&imgtype=0&src=http%3A%2F%2Fimg.11665.com%2Fimg2_p3%2Fi3%2F336731373%2FTB2o_E6spXXXXboXpXXXXXXXXXX_%2521%2521336731373.jpg",
                          height: ScreenUtil().setHeight(70),
                          width: ScreenUtil().setWidth(60),
                          fit: BoxFit.fitWidth),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(1.6),
                    ),
                    Center(
                        child: Text(_dataSource[index].name.length>8?_dataSource[index].name.substring(0,8):_dataSource[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: ScreenUtil().setSp(9)))),
                    SizedBox(
                      height: ScreenUtil().setHeight(1.5),
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("¥" + _dataSource[index].salePrice.toString(),
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(9),
                                color: Colors.deepOrange)),
                        SizedBox(
                          width: ScreenUtil().setWidth(3.3),
                        ),
                        Text("¥" + _dataSource[index].originalPrice.toString(),
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: ScreenUtil().setSp(9),
                                color: Colors.black))
                      ],
                    )),
                  ],
                ),
              ),
            )));
  }

  Widget _buildCenterPic(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27),
            ScreenUtil().setHeight(13), ScreenUtil().setWidth(27), 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () async {
                //const url = "tmall://https://detail.tmall.com/item.htm?spm=a220m.1000862.1000725.1.283b8dfc2NPpZj&id=39488472991&areaId=440100&is_b=1&cat_id=2&rn=4311899ea7b527699f5a4a7ff56392b9&skuId=53414662968";
                //const iosUrl = "https://detail.tmall.com/item.htm?spm=a220m.1000862.1000725.1.283b8dfc2NPpZj&id=39488472991&areaId=440100&is_b=1&cat_id=2&rn=4311899ea7b527699f5a4a7ff56392b9&skuId=53414662968";
                if (await canLaunch(url)) {
                  await launch(url);
                } else if (await canLaunch(iosUrl)) {
                  await launch(iosUrl);
                } else {
                  throw "不可以打开App";
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(3.3)),
                    child: Image.asset(
                      "assets/sale.png",
                      scale: 1.8,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      child: Image.network(
                        promotionUrl,
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(43.67),
                        height: ScreenUtil().setWidth(45),
                      )),
                  SizedBox(
                    width: ScreenUtil().setWidth(20),
                  ),
                  Column(
                    children: [
                      Text(
                        promotionTitle.length>8?promotionTitle.substring(0,8):promotionTitle,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenUtil().setSp(10)),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(7),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(78),
                        height: ScreenUtil().setHeight(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              promotionPrice,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(10)),
                            Text(
                              promotionNewPrice,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.red),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/tips_Price_rectangle@3x.png",
                                ),
                                fit: BoxFit.fill)),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(6.3),
            ),
            _product()
            // GridView()
          ],
        ));
  }
}
