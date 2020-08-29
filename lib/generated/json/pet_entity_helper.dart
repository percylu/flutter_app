import 'package:flutter_app/entity/pet_entity.dart';

petEntityFromJson(PetEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new List<PetData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new PetData().fromJson(v));
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

Map<String, dynamic> petEntityToJson(PetEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['message'] = entity.message;
	data['success'] = entity.success;
	return data;
}

petDataFromJson(PetData data, Map<String, dynamic> json) {
	if (json['birthday'] != null) {
		data.birthday = json['birthday']?.toString();
	}
	if (json['createTime'] != null) {
		data.createTime = json['createTime']?.toString();
	}
	if (json['imgurls'] != null) {
		data.imgurls = json['imgurls']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['petId'] != null) {
		data.petId = json['petId']?.toString();
	}
	if (json['rdid'] != null) {
		data.rdid = json['rdid']?.toString();
	}
	if (json['sexy'] != null) {
		data.sexy = json['sexy']?.toInt();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['updateTime'] != null) {
		data.updateTime = json['updateTime']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['weight'] != null) {
		data.weight = json['weight']?.toInt();
	}
	return data;
}

Map<String, dynamic> petDataToJson(PetData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['birthday'] = entity.birthday;
	data['createTime'] = entity.createTime;
	data['imgurls'] = entity.imgurls;
	data['name'] = entity.name;
	data['petId'] = entity.petId;
	data['rdid'] = entity.rdid;
	data['sexy'] = entity.sexy;
	data['type'] = entity.type;
	data['updateTime'] = entity.updateTime;
	data['userId'] = entity.userId;
	data['weight'] = entity.weight;
	return data;
}