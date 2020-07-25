import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:luhenchang_plugin/time/data_time_utils/data_time.dart';

class DayChart extends StatefulWidget {
  //DayChart(this.data);
  @override
  _DayChartState createState() => _DayChartState();
//final String date;
//final List<DayDatas> data;

}

class _DayChartState extends State<DayChart> {
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
    return Column(
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
            height: ScreenUtil().setWidth(545.01),
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
        viewport: charts.OrdinalViewport('0:00', 6),
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
    DatePicker.showDatePicker(
      context,
      initialDateTime: DateTime.now(),
      dateFormat: "yyyy.MM.dd",
      onCancel: () {},
      onConfirm: (data, i) {
        setState(() {
          _date = data.toString().substring(0, 10);
        });
        //print(data.toString().substring(0,10));
      },
    );
  }

  initData() {
    data = [
      new DayDatas("0:00", 20),
      new DayDatas("1:00", 50),
      new DayDatas("2:00", 20),
      new DayDatas("3:00", 80),
      new DayDatas("4:00", 120),
      new DayDatas("5:00", 30),
      new DayDatas("6:00", 20),
      new DayDatas("7:00", 50),
      new DayDatas("8:00", 20),
      new DayDatas("9:00", 80),
      new DayDatas("10:00", 120),
      new DayDatas("11:00", 30),
    ];
  }
}

// 柱状图
class DayDatas {
  String day;
  int kg;

  DayDatas(this.day, this.kg);
}
