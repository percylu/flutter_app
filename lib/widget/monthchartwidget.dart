import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide DateUtils;
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:luhenchang_plugin/time/data_time_utils/data_time.dart';

class MonthChart extends StatefulWidget {
  //DayChart(this.data);
  @override
  _MonthChartState createState() => _MonthChartState();
//final String date;
//final List<DayDatas> data;

}

class _MonthChartState extends State<MonthChart> {
  var _date = DateUtils.instance.getFormartDate(
      DateTime.now().millisecondsSinceEpoch,
      format: "yyyy-MM");
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
                top: ScreenUtil().setHeight(10),
                bottom: ScreenUtil().setHeight(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${_date}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w700),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () {
                    _showDatePick(context);
                  },
                )
              ],
            )),
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
        viewport: charts.OrdinalViewport('${data[0]}', 6),
      ),
      behaviors: [new charts.PanAndZoomBehavior()],
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec()),
//      defaultRenderer: new charts.BarRendererConfig(
//          layoutPaintOrder:charts.LayoutViewPaintOrder.chartTitle,
//          strokeWidthPx: 1.0),
    );
  }

  _showDatePick(BuildContext context) {
    //showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.parse("2000-01-01"), lastDate: DateTime.parse("2050-01-01"));

    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: "yyyy.MM",
      onCancel: () {},
      onConfirm: (data, i) {
        setState(() {
          _date = data.toString().substring(0, 7);
        });
        //print(data.toString().substring(0,10));
      },
    );
  }

  initData() {
    data = [
      new DayDatas("8.1", 20),
      new DayDatas("8.2", 21),
      new DayDatas("8.3", 30),
      new DayDatas("8.4", 17),
      new DayDatas("8.5", 18),
      new DayDatas("8.6", 30),
      new DayDatas("8.7", 30),
      new DayDatas("8.8", 18),
      new DayDatas("8.9", 20),
      new DayDatas("8.10", 21),
      new DayDatas("8.11", 22),
      new DayDatas("8.12", 16),
      new DayDatas("8.13", 31),
      new DayDatas("8.14", 29),
      new DayDatas("8.15", 30),
      new DayDatas("8.16", 21),
      new DayDatas("8.17", 34),
      new DayDatas("8.18", 21),
      new DayDatas("8.19", 31),
      new DayDatas("8.20", 18),





    ];
  }
}

// 柱状图
class DayDatas {
  String day;
  int kg;

  DayDatas(this.day, this.kg);
}
