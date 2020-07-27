class deviceBean {
  int code;
  int count;
  List<Data> data;
  String msg;

  deviceBean({this.code, this.count, this.data, this.msg});

  deviceBean.fromJson(Map<String, dynamic> json) {
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
  String desc;
  String mac;

  Data({this.id, this.imgUrl, this.desc, this.mac});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['imgUrl'];
    desc = json['desc'];
    mac = json['mac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imgUrl'] = this.imgUrl;
    data['desc'] = this.desc;
    data['mac'] = this.mac;
    return data;
  }
}