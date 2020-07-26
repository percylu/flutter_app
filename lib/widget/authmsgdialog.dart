// ignore: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class AuthMsgDialog extends Dialog {
  String img;
  String message;
  String negativeText;
  Function onCloseEvent;
  Function onConfirmEvent;

  AuthMsgDialog({
    Key key,
    @required this.img,
    @required this.message,
    this.negativeText,
    @required this.onCloseEvent,
    this.onConfirmEvent
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true);
    return new Container(

      padding: const EdgeInsets.only(top:60,left:80,right:80,bottom: 20),
      child: new Material(
        type: MaterialType.transparency,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width:ScreenUtil().setWidth(399.99),
              height: ScreenUtil().setHeight(399.99),
              padding:EdgeInsets.only(top:20,left:0,right:0,bottom: 0),
              decoration: ShapeDecoration(
                color: Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                    side:BorderSide(
                      color :Color(0xff545253),
                      width : 3.0,
                      style : BorderStyle.solid,
                    ),
                ),
              ),
              margin: const EdgeInsets.only(top:20),
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: new Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: <Widget>[
                        new Center(
                          child: Image.asset(img,
                          width:ScreenUtil().setWidth(80.01),
                          height:ScreenUtil().setHeight(60)
                          ),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    constraints: BoxConstraints(minHeight: 80.0),
                    child: new Padding(
                      padding: const EdgeInsets.only(left:40.0,right:40.0,top:10),
                      child: new IntrinsicHeight(
                        child: new Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16.0,color: Color(0xffAC8C8C),fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                    color: Color(0xff545253),
                    height: 2,
                  ),
                  this._buildBottomButtonGroup(),
                ],
              ),
            ),
            new GestureDetector(
              onTap: this.onCloseEvent,
              child: new Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor:Color(0xff545253),
                  child:new Icon(
                  Icons.close,
                  color: Color(0xff545253),
                ),),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildBottomButtonGroup() {
    var widgets = <Widget>[];
    if (negativeText != null && negativeText.isNotEmpty) widgets.add(_buildBottomCancelButton());
    return new Flex(
      direction: Axis.horizontal,
      children: widgets,
    );
  }

  Widget _buildBottomCancelButton() {
    return new Flexible(
      fit: FlexFit.tight,
      child: new FlatButton(
        onPressed: onConfirmEvent,
        child: new Text(
          negativeText,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(32),
            color: Color(0xFFF28282),
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }


}