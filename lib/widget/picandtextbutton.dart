
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
        width: 350,
        height: 445,
        allowFontScaling: true);
    return Container(
      width: ScreenUtil().setWidth(125.33),
      height: ScreenUtil().setWidth(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(imgpath),
            fit: BoxFit.cover
        ),
      ),
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: this.onPress,
        child: Text(text,style: TextStyle(fontFamily: 'YaHeiBold',fontSize:ScreenUtil().setSp(12),fontWeight: FontWeight.w800)),
        color: Colors.transparent,
      ),
    );

  }


}
