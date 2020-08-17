import 'package:flutter_app/entity/device_entity.dart';

deviceEntityFromJson(DeviceEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<DeviceData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new DeviceData().fromJson(v));
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

Map<String, dynamic> deviceEntityToJson(DeviceEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	data['success'] = entity.success;
	return data;
}

deviceDataFromJson(DeviceData data, Map<String, dynamic> json) {
	if (json['imgUrl'] != null) {
		data.imgUrl = json['imgUrl']?.toString();
	}
	if (json['litter'] != null) {
		data.litter = json['litter']?.toInt();
	}
	if (json['color'] != null) {
		data.color = json['color']?.toString();
	}
	if (json['rubbish'] != null) {
		data.rubbish = json['rubbish']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['deviceId'] != null) {
		data.deviceId = json['deviceId']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['deviceSn'] != null) {
		data.deviceSn = json['deviceSn']?.toString();
	}
	if (json['tims'] != null) {
		data.tims = json['tims']?.toInt();
	}
	return data;
}

Map<String, dynamic> deviceDataToJson(DeviceData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['imgUrl'] = entity.imgUrl;
	data['litter'] = entity.litter;
	data['color'] = entity.color;
	data['rubbish'] = entity.rubbish;
	data['type'] = entity.type;
	data['deviceId'] = entity.deviceId;
	data['userId'] = entity.userId;
	data['deviceSn'] = entity.deviceSn;
	data['tims'] = entity.tims;
	return data;
}