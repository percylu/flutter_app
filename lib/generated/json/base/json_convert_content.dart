// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_app/entity/pet_entity.dart';
import 'package:flutter_app/generated/json/pet_entity_helper.dart';
import 'package:flutter_app/entity/pet_type_entity.dart';
import 'package:flutter_app/generated/json/pet_type_entity_helper.dart';
import 'package:flutter_app/entity/pet_detail_entity.dart';
import 'package:flutter_app/generated/json/pet_detail_entity_helper.dart';
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
    switch (type) {			case PetEntity:
			return petEntityFromJson(data as PetEntity, json) as T;			case PetData:
			return petDataFromJson(data as PetData, json) as T;			case PetTypeEntity:
			return petTypeEntityFromJson(data as PetTypeEntity, json) as T;			case PetTypeData:
			return petTypeDataFromJson(data as PetTypeData, json) as T;			case PetDetailEntity:
			return petDetailEntityFromJson(data as PetDetailEntity, json) as T;			case PetDetailData:
			return petDetailDataFromJson(data as PetDetailData, json) as T;			case DeviceEntity:
			return deviceEntityFromJson(data as DeviceEntity, json) as T;			case DeviceData:
			return deviceDataFromJson(data as DeviceData, json) as T;			case LoginEntity:
			return loginEntityFromJson(data as LoginEntity, json) as T;			case LoginData:
			return loginDataFromJson(data as LoginData, json) as T;			case LoginDataUser:
			return loginDataUserFromJson(data as LoginDataUser, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case PetEntity:
			return petEntityToJson(data as PetEntity);			case PetData:
			return petDataToJson(data as PetData);			case PetTypeEntity:
			return petTypeEntityToJson(data as PetTypeEntity);			case PetTypeData:
			return petTypeDataToJson(data as PetTypeData);			case PetDetailEntity:
			return petDetailEntityToJson(data as PetDetailEntity);			case PetDetailData:
			return petDetailDataToJson(data as PetDetailData);			case DeviceEntity:
			return deviceEntityToJson(data as DeviceEntity);			case DeviceData:
			return deviceDataToJson(data as DeviceData);			case LoginEntity:
			return loginEntityToJson(data as LoginEntity);			case LoginData:
			return loginDataToJson(data as LoginData);			case LoginDataUser:
			return loginDataUserToJson(data as LoginDataUser);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'PetEntity':
			return PetEntity().fromJson(json);			case 'PetData':
			return PetData().fromJson(json);			case 'PetTypeEntity':
			return PetTypeEntity().fromJson(json);			case 'PetTypeData':
			return PetTypeData().fromJson(json);			case 'PetDetailEntity':
			return PetDetailEntity().fromJson(json);			case 'PetDetailData':
			return PetDetailData().fromJson(json);			case 'DeviceEntity':
			return DeviceEntity().fromJson(json);			case 'DeviceData':
			return DeviceData().fromJson(json);			case 'LoginEntity':
			return LoginEntity().fromJson(json);			case 'LoginData':
			return LoginData().fromJson(json);			case 'LoginDataUser':
			return LoginDataUser().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'PetEntity':
			return List<PetEntity>();			case 'PetData':
			return List<PetData>();			case 'PetTypeEntity':
			return List<PetTypeEntity>();			case 'PetTypeData':
			return List<PetTypeData>();			case 'PetDetailEntity':
			return List<PetDetailEntity>();			case 'PetDetailData':
			return List<PetDetailData>();			case 'DeviceEntity':
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