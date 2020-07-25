
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class picAndPicButton extends StatelessWidget{
  picAndPicButton(this.imgpath,this.text,this.onPress);
  final String imgpath;
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: ListView(
          children:<Widget>[
            SizedBox(height: 20,),
            Image.asset(imgpath,width:50 ,height:37 ,),
            SizedBox(height: 10,),
            Image.asset(text,width:37 ,height:14.5 ,),
          ]
      ),
      onTap: onPress,
    );


  }


}
