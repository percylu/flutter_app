import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_screenutil/screenutil.dart';
import 'package:luhenchang_plugin/time/data_time_utils/data_time.dart';

class WeekChart extends StatefulWidget {
  //DayChart(this.data);
  @override
  _WeekChartState createState() => _WeekChartState();
//final String date;
//final List<DayDatas> data;

}

class _WeekChartState extends State<WeekChart> {
  var _date = DateUtils.instance.getFormartDate(
      DateTime.now().millisecondsSinceEpoch,
      format: "yyyy-MM-dd");
  List<DayDatas> data=new List();

  //_DayChartState(this.data);
  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
    return ListView(
      children: [
    Padding(
    padding: EdgeInsets.only(
    top: ScreenUtil().setHeight(50),
    bottom: ScreenUtil().setHeight(50))),
        Container(
            width: ScreenUtil().setWidth(603.99),
            height: ScreenUtil().setWidth(515.01),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                //color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 0.0), //阴影xy轴偏移量
                      blurRadius: 1.0, //阴影模糊程度
                      spreadRadius: 1.0 //阴影扩散程度
                      )
                ],
                borderRadius: BorderRadius.circular(20)),
            alignment: Alignment.center,
            child: getBar())
      ],
    );
  }

  Widget getBar() {
    var seriesBar = [
      charts.Series(
        data: data,
        //seriesColor:Color(r: 0, g: 0, b: 0, a: 0),
        domainFn: (DayDatas days, _) => days.day,
        measureFn: (DayDatas days, _) => days.kg,
        labelAccessorFn: (DayDatas days, _) => '${days.kg.toString()}',
        id: "Days",
        colorFn: (DayDatas days, _) => charts.MaterialPalette.black,
        fillColorFn: (DayDatas days, _) => charts.MaterialPalette.gray.shade300,
      )
    ];
    return charts.BarChart(
      seriesBar,
      animate: true,
      barRendererDecorator: new charts.BarLabelDecorator<String>(
        labelPosition: charts.BarLabelPosition.outside,
        // outsideLabelStyleSpec: TextStyleSpec(color:MaterialPalette.black)
      ),
      domainAxis: new charts.OrdinalAxisSpec(
        viewport: charts.OrdinalViewport('M', 7),
      ),
      behaviors: [new charts.PanAndZoomBehavior()],
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec()),
//      defaultRenderer: new charts.BarRendererConfig(
//          layoutPaintOrder:charts.LayoutViewPaintOrder.chartTitle,
//          strokeWidthPx: 1.0),
    );
  }



  initData() {
    data = [
      new DayDatas("M", 20),
      new DayDatas("T", 30),
      new DayDatas("W", 21),
      new DayDatas("T", 22),
      new DayDatas("F", 18),
      new DayDatas("S", 20),
      new DayDatas("S", 21),

    ];
  }
}

// 柱状图
class DayDatas {
  String day;
  int kg;

  DayDatas(this.day, this.kg);
}
