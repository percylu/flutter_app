
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class deviceScanButton extends StatelessWidget{
  deviceScanButton(this.text,this.onPress);
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true);
    return
      GestureDetector(
          onTap: this.onPress,
          child:
          Container(
              width: ScreenUtil().setWidth(650),

              height: ScreenUtil().setHeight(90),
              margin: EdgeInsets.all(ScreenUtil().setWidth(20)),
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/bg_search.png"),
                    fit: BoxFit.fill
                ),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  FlatButton(
                    onPressed: this.onPress,
                    child: Text(text,style: TextStyle(color:Color(0xFF4A3D3D)),),
                    color: Colors.transparent,
                  ),
                  SizedBox(width: ScreenUtil().setWidth(150),),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 36,
                    color: Color(0xFF4A3D3D),
                  ),

                ],
              )

          )
      );


  }


}
