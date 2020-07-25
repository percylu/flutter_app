
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class picAndTextButton extends StatelessWidget{
  picAndTextButton(this.imgpath,this.text,this.onPress);
  final String imgpath;
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1334,
        allowFontScaling: true);
    return Container(
      width: ScreenUtil().setWidth(288.99),
      height: ScreenUtil().setWidth(86.01),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(imgpath),
            fit: BoxFit.fill
        ),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: this.onPress,
        child: Text(text),
        color: Colors.transparent,
      ),
    );

  }


}
