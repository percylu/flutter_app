import 'package:flutter_app/entity/pet_type_entity.dart';

petTypeEntityFromJson(PetTypeEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<PetTypeData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new PetTypeData().fromJson(v));
		});
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['success'] != null) {
		data.success = json['success'];
	}
	return data;
}

Map<String, dynamic> petTypeEntityToJson(PetTypeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	data['success'] = entity.success;
	return data;
}

petTypeDataFromJson(PetTypeData data, Map<String, dynamic> json) {
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['typeId'] != null) {
		data.typeId = json['typeId']?.toString();
	}
	if (json['typeName'] != null) {
		data.typeName = json['typeName']?.toString();
	}
	if (json['updateTime'] != null) {
		data.updateTime = json['updateTime']?.toString();
	}
	return data;
}

Map<String, dynamic> petTypeDataToJson(PetTypeData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['createTime'] = entity.createTime;
	data['typeId'] = entity.typeId;
	data['typeName'] = entity.typeName;
	data['updateTime'] = entity.updateTime;
	return data;
}