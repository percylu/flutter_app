  import 'dart:collection';

  //import 'package:barcode_scan/platform_wrapper.dart';
  import 'package:barcode_scan/barcode_scan.dart';
  import 'package:barcode_scan/platform_wrapper.dart';
  import 'package:cached_network_image/cached_network_image.dart';
  import 'package:dio/dio.dart';
  import 'package:flutter/cupertino.dart';
  import 'dart:io';
  /**
   * Author: Damodar Lohani
   * profile: https://github.com/lohanidamodar
   */

  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_app/api/MiaoApi.dart';
  import 'package:flutter_app/entity/login_entity.dart';
  import 'package:flutter_app/entity/pet_detail_entity.dart';
  import 'package:flutter_app/entity/pet_entity.dart';
  import 'package:flutter_app/entity/pet_type_entity.dart';
  import 'package:flutter_app/generated/json/base/json_convert_content.dart';
  import 'package:flutter_app/ui/petlist.dart';
  import 'package:flutter_app/utility/Config.dart';
  import 'package:flutter_app/utility/ResultData.dart';
  import 'package:flutter_app/utility/SpUtils.dart';
  import 'package:flutter_app/widget/messagedialog.dart';
  import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
  import 'package:flutter_luban/flutter_luban.dart';
  import 'package:flutter_screenutil/flutter_screenutil.dart';
  import 'package:image_picker/image_picker.dart';
  import 'package:luhenchang_plugin/time/data_time_utils/data_time.dart';

  class AddPet extends StatefulWidget {

    @override
    _AddPetState createState() => _AddPetState();
  }

  class _AddPetState extends State<AddPet> {
    var _sexy = 0;
    var _imglist = ["","",""];
    PetDetailEntity items;
    List<Map<String, String>> petTypes = [];
    var petNameController = new TextEditingController();
    var petTypeController = new TextEditingController();
    var petWeightController = new TextEditingController();
    var petBirthController = new TextEditingController();
    var petRFIDController = new TextEditingController();

    @override
    void initState() {
      super.initState();
      initData();
    }

    @override
    Widget build(BuildContext context) {
      ScreenUtil.init(
          width: 250,
          height: 445,
          allowFontScaling: true); //flutter_screenuitl >= 1.2

      return Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.5,
            leading: IconButton(
              icon: Image.asset(
                "assets/ic_back.png",
                width: 12,
                height: 20,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            actions: [
              FlatButton(
                  child: Text(
                    "保存",
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(12)),
                  ),
                  onPressed: () async{
                    await update();
                  }),
            ],
            backgroundColor: Colors.white,
            title: Text(
              "宠物资料",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
              child: Stack(children: [
            Container(
                constraints: BoxConstraints(
                  minHeight: ScreenUtil().setHeight(306.66),
                ),
                width: ScreenUtil().setWidth(190),
                height: ScreenUtil().setHeight(306.66),
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    right: ScreenUtil().setWidth(30),
                    top: ScreenUtil().setHeight(37.33),
                    bottom: ScreenUtil().setHeight(25.33)),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFF525152),
                      width: 3.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: ScreenUtil().setHeight(30.66),
                    bottom: ScreenUtil().setHeight(17),
                    left: ScreenUtil().setWidth(19.33),
                    // right: ScreenUtil().setWidth(10.33)
                  ),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Text("名字",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(60.66),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(70.66),
                            child: TextField(
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w700),
                              controller: petNameController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0)),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("品种",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(72.66),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(57.66),
                            child: petTypes.length==0
                                ? Container(
                                    height: ScreenUtil().setHeight(28),
                                  )
                                : Container(
                                    alignment: Alignment.bottomLeft,
                                    child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                            value: petTypeController.text,
                                            items: petTypes
                                                .map((item) => DropdownMenuItem(
                                                      value: item['id'],
                                                      child: Text(
                                                        item['type'],
                                                        style: TextStyle(
                                                          color: Colors.black26,
                                                          fontSize: ScreenUtil()
                                                              .setSp(10),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            onChanged: (newValue) {
                                              setState(() {
                                                petTypeController.text = newValue;
                                              });
                                            }))),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("性别",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(72.66),
                          ),
                          SizedBox(
                              width: ScreenUtil().setWidth(59.66),
                              child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  alignment: Alignment.bottomLeft,
  //
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          value: _sexy,
                                          //value:_sexy==0?"男":"女",
                                          items: [
                                            DropdownMenuItem(
                                              child: Text('男孩',
                                                  style: TextStyle(
                                                    color: Colors.black26,
                                                    fontSize:
                                                        ScreenUtil().setSp(10),
                                                    fontWeight: FontWeight.w700,
                                                  )),
                                              value: 0,
                                            ),
                                            DropdownMenuItem(
                                                child: Text('女孩',
                                                    style: TextStyle(
                                                      color: Colors.black26,
                                                      fontSize:
                                                          ScreenUtil().setSp(10),
                                                      fontWeight: FontWeight.w700,
                                                    )),
                                                value: 1),
                                          ],
                                          onChanged: (value) {
                                            setState(() {
                                              _sexy = value;
                                            });
                                          }))))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("重量",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(58.66),
                          ),
                          SizedBox(
                              width: ScreenUtil().setWidth(40.66),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w700),
                                  controller: petWeightController,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 16.0)),
                                ),
                              )),
                          SizedBox(
                            child: Text("KG",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(10),
                                    color: Colors.black26,
                                    fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("生日",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(72.66),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(70),
                            child: GestureDetector(
                              onTap:() {
                                 _showDatePick(context);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: ScreenUtil().setHeight(30),
                                child: Text(
                                  petBirthController.text,
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(10),
                                      color: Colors.black26,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("RFID",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                          SizedBox(
                            width: ScreenUtil().setWidth(70.66),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(40.66),
                            child:
                            GestureDetector(onTap: ()async{
                              var result = await BarcodeScanner.scan();
                              petRFIDController.text=result.rawContent;
                              setState(() {

                              });

                            },child: Container(
                              alignment: Alignment.centerLeft,
                              height: ScreenUtil().setHeight(30),child:Text(
                              petRFIDController.text,
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  color: Colors.black26,
                                  fontWeight: FontWeight.w700),
                            ),)),
                            ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: ScreenUtil().setWidth(20),
                            bottom: ScreenUtil().setHeight(10)),
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      Row(
                        children: [
                          Text("照片(最多三张)",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(10),
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(8),
                                bottom: ScreenUtil().setHeight(8),
                                right: ScreenUtil().setHeight(0)),
                            child: GestureDetector(
                              onTap: () async{
                                await _showPicPicker(context,0);
                              },
                              child: _imglist[0]!=""?
                              CachedNetworkImage(
                                imageUrl: _imglist[0],
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setWidth(34.66),
                                placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                                fit: BoxFit.fill,
                              )
                                  :Image.asset(
                                "assets/pic_add_pet.png",
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setHeight(34.66),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(ScreenUtil().setHeight(8)),
                            child: GestureDetector(
                              onTap: () async{
                                await _showPicPicker(context,1);

                              },
                              child:  _imglist[1]!=""?
                              CachedNetworkImage(
                                imageUrl: _imglist[1],
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setWidth(34.66),
                                placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                                fit: BoxFit.fill,
                              ):Image.asset(
                                "assets/pic_add_pet.png",
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setHeight(34.66),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ScreenUtil().setHeight(8),
                                bottom: ScreenUtil().setHeight(8),
                                right: ScreenUtil().setHeight(0)),
                            child: GestureDetector(
                              onTap: () async{
                               await _showPicPicker(context,2);
                              },
                              child: _imglist[2]!=""?
                              CachedNetworkImage(
                                imageUrl: _imglist[2],
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setWidth(34.66),
                                placeholder: (context, url) =>
                                new CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                new Icon(Icons.error),
                                fit: BoxFit.fill,
                              ):Image.asset(
                                "assets/pic_add_pet.png",
                                width: ScreenUtil().setWidth(35.66),
                                height: ScreenUtil().setHeight(34.66),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
            Positioned(
                top: ScreenUtil().setHeight(13),
                // left:ScreenUtil().setWidth(128),
                right: ScreenUtil().setWidth(10),
                child: GestureDetector(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(63),
                      child: CachedNetworkImage(
                        imageUrl: items == null
                            ? ""
                            : SpUtils.URL + items.data.imgurls.split(",")[0],
                        width: ScreenUtil().setWidth(63),
                        height: ScreenUtil().setWidth(63),
                        placeholder: (context, url) =>
                            new CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        fit: BoxFit.fill,
                      )),
                )),
          ])));
    }

    initData() async {
      petNameController.text = "";
      petTypeController.text = "";
      _sexy = 0;
      petWeightController.text = "0";
      petBirthController.text = DateUtils.instance.getFormartDate(
          DateTime.now().millisecondsSinceEpoch,
          format: "yyyy-MM-dd");
      petRFIDController.text = "点击扫码";
      ResultData types = await MiaoApi.petTypeList();
      if (types.code == 200) {
        PetTypeEntity petTypeEntity = JsonConvert.fromJsonAsT(types.data);
        petTypeController.text=petTypeEntity.data[0].typeId;
        petTypeEntity.data.forEach((element) {
          petTypes.add({"id": element.typeId, "type": element.typeName});
        });
      } else if (types.code == 1502) {
        _showError("请先登陆", types.message);
        Navigator.pushReplacementNamed(context, "home");
      } else {
        _showError("获取品种", types.message);
      }
      setState(() {});
    }

    _showError(String title, String msg) {
      showDialog<Null>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new MessageDialog(
              title: title,
              message: msg,
              negativeText: "返回",
              onCloseEvent: () {
                Navigator.pop(context);
              },
              onConfirmEvent: () {
                Navigator.pop(context);
              },
            );
          });
    }

    _showPicPicker(BuildContext context,int index) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
              height: ScreenUtil().setHeight(80),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                          child: Text("拍照",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(12),
                                  fontWeight: FontWeight.w500)),
                          onTap: () {
                            _takePhotos(index);
                            Navigator.pop(context, true);
                          })),

                  //  SizedBox(height:ScreenUtil().setHeight(15) ,),
                  Expanded(
                    child: GestureDetector(
                        child: Text("相册",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(12),
                                fontWeight: FontWeight.w500)),
                        onTap: () {
                          _getPhotos(index);
                          Navigator.pop(context, true);
                        }),
                  ),
                ],
              ),
            );
          });
    }

    _takePhotos(int index) async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      _uploadImage(image,index);
    }

    //获取相册照片
    _getPhotos(int index) async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      _uploadImage(image,index);
    }

    Future<Map<String, dynamic>> _uploadImage(File _imageDir,int index) async {
      setState(() {
        _imglist[index] =
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2467429933,3710707406&fm=26&gp=0.jpg";
      });
      var fileDir = _imageDir.parent.path;
      print("fileDir:-------" + fileDir);
      CompressObject compressObject = CompressObject(
        imageFile: _imageDir,
        path: fileDir,
        quality: 70,
        //first compress quality, default 80
        step: 20,
        //compress quality step, The bigger the fast, Smaller is more accurate, default 6
        mode: CompressMode.LARGE2SMALL, //d
      );
      Luban.compressImage(compressObject).then((fileDir) async {
        // _path为压缩后图片路径
        File newImage = new File(fileDir);
        print("newImage:-----" + newImage.path);
        FormData formData = FormData.fromMap({
          "file": await MultipartFile.fromFile(newImage.path, filename: "aa.jpg"),
        });
        ResultData response = await MiaoApi.upload(formData);
        if (response.code == 200) {
          _imglist[index] =
              SpUtils.URL + '/image/' + response.data['data']['finalName'];
          setState(() {

          });
        }
      });
    }

    update() async {
      var data = await SpUtils.getObjact(Config.USER);
      LoginEntity user = JsonConvert.fromJsonAsT(data);
      PetData petData=new PetData();
      var arr=[];
      _imglist.forEach((element) {
        if(element!=""){
          var index=element.indexOf("/image");
            arr.add(element.substring(index));
        }
      });
      petData.imgurls=arr.join(",");
      petData.userId=user.data.user.userId;
      petData.rdid=petRFIDController.text;
      petData.birthday=petBirthController.text;
      petData.weight=int.parse(petWeightController.text);
      petData.name=petNameController.text;
      petData.sexy=_sexy;
      petData.type=petTypeController.text;
      ResultData response = await MiaoApi.petAdd(petData);
      if(response.code==200){
        Navigator.of(context)
            .pushReplacement(new MaterialPageRoute(builder: (_) {
          return new PetList();
        }));
      }else if(response.code==1502){
        Navigator.pushReplacementNamed(context, "home");
      }else{
        _showError("更新宠物资料失败", response.message);
      }

    }
    _showDatePick(BuildContext context) {
      //showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.parse("2000-01-01"), lastDate: DateTime.parse("2050-01-01"));
      DatePicker.showDatePicker(
        context,
        initialDateTime: DateTime.now(),
        dateFormat: "yyyy.MM.dd",
        onCancel: () {},
        onConfirm: (data, i) {
          setState(() {
            petBirthController.text = data.toString().substring(0, 10);
          });
          //print(data.toString().substring(0,10));
        },
      );
    }

  }
