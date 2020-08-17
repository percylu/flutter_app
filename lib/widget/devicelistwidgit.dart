
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DeviceListWidget extends StatelessWidget{
  DeviceListWidget(this.imgpath,this.devicecolor,this.type,this.onPlay,this.onClose);
  final String imgpath;
  final String devicecolor;
  final String type;
  final VoidCallback onPlay;
  final VoidCallback onClose;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 750,
        height: 1335,
        allowFontScaling: true);
    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(51)),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      child:Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CachedNetworkImage(
            imageUrl: imgpath,
            width: ScreenUtil().setWidth(341.01),
            height: ScreenUtil().setHeight(246.09),
            placeholder: (context, url) =>Image.asset("assets/img_cat.png",width: ScreenUtil().setWidth(341.01),height: ScreenUtil().setHeight(246.09),),
            errorWidget: (context, url, error) =>Image.asset("assets/img_cat.png",width: ScreenUtil().setWidth(341.01),height: ScreenUtil().setHeight(246.09),),
            fit: BoxFit.fill,
          ),
          SizedBox(width: ScreenUtil().setWidth(30),),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: ScreenUtil().setHeight(39),),
              Text(devicecolor,style: TextStyle(color:Colors.grey,fontSize: 16,fontWeight: FontWeight.w700),textAlign: TextAlign.right,),
              SizedBox(height: 5,),
              Text(type,style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.w700),textAlign: TextAlign.right,),
              SizedBox(height: ScreenUtil().setHeight(5),),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  IconButton(
                    icon:Image.asset("assets/ic_enter.png"),
                    iconSize: ScreenUtil().setWidth(83.01),
                    onPressed: this.onPlay,

                  ),
                  SizedBox(width: ScreenUtil().setWidth(10)),

                  IconButton(
                    icon:Image.asset("assets/ic_delete.png"),
                    onPressed: this.onClose,
                      iconSize: ScreenUtil().setWidth(83.01),
                  ),
              ],
            )
          ],)
        ],
      )
    );

  }


}
