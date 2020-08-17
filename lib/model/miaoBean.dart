class miaoBean {
  int code;
  int count;
  List<Data> data;
  String msg;

  miaoBean({this.code, this.count, this.data, this.msg});

  miaoBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    count = json['count'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['count'] = this.count;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  int id;
  String imgUrl;
  String name;
  String nickName;
  String birth;
  String weight;
  int sexy;
  String rfid;
  List<String> bigImg;

  Data(
      {this.id,
        this.imgUrl,
        this.name,
        this.nickName,
        this.birth,
        this.weight,
        this.sexy,
        this.rfid,
        this.bigImg});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
    name = json['name'];
    nickName = json['nickName'];
    birth = json['birth'];
    weight = json['weight'];
    sexy = json['sexy'];
    rfid = json['rfid'];
    bigImg = json['bigImg'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['birth'] = this.birth;
    data['weight'] = this.weight;
    data['sexy'] = this.sexy;
    data['rfid'] = this.rfid;
    data['bigImg'] = this.bigImg;
    return data;
  }
}