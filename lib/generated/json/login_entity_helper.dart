import 'package:flutter_app/entity/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
	if (json['code'] != null) {
		data.code = json['code']?.toInt();
	}
	if (json['data'] != null) {
		data.data = new LoginData().fromJson(json['data']);
	}
	if (json['message'] != null) {
		data.message = json['message']?.toString();
	}
	if (json['success'] != null) {
		data.success = json['success'];
	}
	return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['code'] = entity.code;
	if (entity.data != null) {
		data['data'] = entity.data.toJson();
	}
	data['message'] = entity.message;
	data['success'] = entity.success;
	return data;
}

loginDataFromJson(LoginData data, Map<String, dynamic> json) {
	if (json['user'] != null) {
		data.user = new LoginDataUser().fromJson(json['user']);
	}
	if (json['token'] != null) {
		data.token = json['token']?.toString();
	}
	return data;
}

Map<String, dynamic> loginDataToJson(LoginData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	data['token'] = entity.token;
	return data;
}

loginDataUserFromJson(LoginDataUser data, Map<String, dynamic> json) {
	if (json['account'] != null) {
		data.account = json['account']?.toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar']?.toString();
	}
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['qq'] != null) {
		data.qq = json['qq']?.toString();
	}
	if (json['sex'] != null) {
		data.sex = json['sex']?.toInt();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['userId'] != null) {
		data.userId = json['userId']?.toString();
	}
	if (json['weibo'] != null) {
		data.weibo = json['weibo']?.toString();
	}
	if (json['weixin'] != null) {
		data.weixin = json['weixin']?.toString();
	}
	return data;
}

Map<String, dynamic> loginDataUserToJson(LoginDataUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['account'] = entity.account;
	data['avatar'] = entity.avatar;
	data['name'] = entity.name;
	data['qq'] = entity.qq;
	data['sex'] = entity.sex;
	data['status'] = entity.status;
	data['userId'] = entity.userId;
	data['weibo'] = entity.weibo;
	data['weixin'] = entity.weixin;
	return data;
}