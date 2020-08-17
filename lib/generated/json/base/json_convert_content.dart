// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_app/entity/device_entity.dart';
import 'package:flutter_app/generated/json/device_entity_helper.dart';
import 'package:flutter_app/entity/login_entity.dart';
import 'package:flutter_app/generated/json/login_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case DeviceEntity:
			return deviceEntityFromJson(data as DeviceEntity, json) as T;			case DeviceData:
			return deviceDataFromJson(data as DeviceData, json) as T;			case LoginEntity:
			return loginEntityFromJson(data as LoginEntity, json) as T;			case LoginData:
			return loginDataFromJson(data as LoginData, json) as T;			case LoginDataUser:
			return loginDataUserFromJson(data as LoginDataUser, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case DeviceEntity:
			return deviceEntityToJson(data as DeviceEntity);			case DeviceData:
			return deviceDataToJson(data as DeviceData);			case LoginEntity:
			return loginEntityToJson(data as LoginEntity);			case LoginData:
			return loginDataToJson(data as LoginData);			case LoginDataUser:
			return loginDataUserToJson(data as LoginDataUser);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'DeviceEntity':
			return DeviceEntity().fromJson(json);			case 'DeviceData':
			return DeviceData().fromJson(json);			case 'LoginEntity':
			return LoginEntity().fromJson(json);			case 'LoginData':
			return LoginData().fromJson(json);			case 'LoginDataUser':
			return LoginDataUser().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'DeviceEntity':
			return List<DeviceEntity>();			case 'DeviceData':
			return List<DeviceData>();			case 'LoginEntity':
			return List<LoginEntity>();			case 'LoginData':
			return List<LoginData>();			case 'LoginDataUser':
			return List<LoginDataUser>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}