/// code : 200
/// data : {"page":1,"pageSize":20,"rows":[{"createTime":"2020-12-05 10:14:01","img":"/image/1336143748609884161.png","link":"https://item.jd.com/10020803518893.html","name":"喵小小","originalPrice":1999,"platform":"京东","productId":"1335044727409594369","promotion":1,"salePrice":1699},{"createTime":"2020-12-05 10:29:26","img":"/image/1335826367262048257.jpeg","link":"https://item.jd.com/100007300763.html","name":"喵小小","originalPrice":55.11,"platform":"京东","productId":"1335048608793350145","promotion":0,"salePrice":22.2},{"createTime":"2020-12-07 13:36:54","img":"/image/1335820543026348034.png","link":"https://item.jd.com/100007300763.html","name":"喵小小2","originalPrice":43.11,"platform":"京东","productId":"1335820560550150145","promotion":0,"salePrice":34.33}],"totalPage":0,"totalRows":3}
/// message : "请求成功"
/// success : true

class ProductBean {
  int _code;
  Data _data;
  String _message;
  bool _success;

  int get code => _code;
  Data get data => _data;
  String get message => _message;
  bool get success => _success;

  ProductBean({
      int code, 
      Data data, 
      String message, 
      bool success}){
    _code = code;
    _data = data;
    _message = message;
    _success = success;
}

  ProductBean.fromJson(dynamic json) {
    _code = json["code"];
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _message = json["message"];
    _success = json["success"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = _code;
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    map["message"] = _message;
    map["success"] = _success;
    return map;
  }

}

/// page : 1
/// pageSize : 20
/// rows : [{"createTime":"2020-12-05 10:14:01","img":"/image/1336143748609884161.png","link":"https://item.jd.com/10020803518893.html","name":"喵小小","originalPrice":1999,"platform":"京东","productId":"1335044727409594369","promotion":1,"salePrice":1699},{"createTime":"2020-12-05 10:29:26","img":"/image/1335826367262048257.jpeg","link":"https://item.jd.com/100007300763.html","name":"喵小小","originalPrice":55.11,"platform":"京东","productId":"1335048608793350145","promotion":0,"salePrice":22.2},{"createTime":"2020-12-07 13:36:54","img":"/image/1335820543026348034.png","link":"https://item.jd.com/100007300763.html","name":"喵小小2","originalPrice":43.11,"platform":"京东","productId":"1335820560550150145","promotion":0,"salePrice":34.33}]
/// totalPage : 0
/// totalRows : 3

class Data {
  int _page;
  int _pageSize;
  List<Rows> _rows;
  int _totalPage;
  int _totalRows;

  int get page => _page;
  int get pageSize => _pageSize;
  List<Rows> get rows => _rows;
  int get totalPage => _totalPage;
  int get totalRows => _totalRows;

  Data({
      int page, 
      int pageSize, 
      List<Rows> rows, 
      int totalPage, 
      int totalRows}){
    _page = page;
    _pageSize = pageSize;
    _rows = rows;
    _totalPage = totalPage;
    _totalRows = totalRows;
}

  Data.fromJson(dynamic json) {
    _page = json["page"];
    _pageSize = json["pageSize"];
    if (json["rows"] != null) {
      _rows = [];
      json["rows"].forEach((v) {
        _rows.add(Rows.fromJson(v));
      });
    }
    _totalPage = json["totalPage"];
    _totalRows = json["totalRows"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["page"] = _page;
    map["pageSize"] = _pageSize;
    if (_rows != null) {
      map["rows"] = _rows.map((v) => v.toJson()).toList();
    }
    map["totalPage"] = _totalPage;
    map["totalRows"] = _totalRows;
    return map;
  }

}

/// createTime : "2020-12-05 10:14:01"
/// img : "/image/1336143748609884161.png"
/// link : "https://item.jd.com/10020803518893.html"
/// name : "喵小小"
/// originalPrice : 1999
/// platform : "京东"
/// productId : "1335044727409594369"
/// promotion : 1
/// salePrice : 1699

class Rows {
  String _createTime;
  String _img;
  String _link;
  String _name;
  double _originalPrice;
  String _platform;
  String _productId;
  int _promotion;
  double _salePrice;

  String get createTime => _createTime;
  String get img => _img;
  String get link => _link;
  String get name => _name;
  double get originalPrice => _originalPrice;
  String get platform => _platform;
  String get productId => _productId;
  int get promotion => _promotion;
  double get salePrice => _salePrice;

  Rows({
      String createTime, 
      String img, 
      String link, 
      String name,
    double originalPrice,
      String platform, 
      String productId, 
      int promotion,
    double salePrice}){
    _createTime = createTime;
    _img = img;
    _link = link;
    _name = name;
    _originalPrice = originalPrice;
    _platform = platform;
    _productId = productId;
    _promotion = promotion;
    _salePrice = salePrice;
}

  Rows.fromJson(dynamic json) {
    _createTime = json["createTime"];
    _img = json["img"];
    _link = json["link"];
    _name = json["name"];
    _originalPrice = json["originalPrice"];
    _platform = json["platform"];
    _productId = json["productId"];
    _promotion = json["promotion"];
    _salePrice = json["salePrice"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["createTime"] = _createTime;
    map["img"] = _img;
    map["link"] = _link;
    map["name"] = _name;
    map["originalPrice"] = _originalPrice;
    map["platform"] = _platform;
    map["productId"] = _productId;
    map["promotion"] = _promotion;
    map["salePrice"] = _salePrice;
    return map;
  }

}