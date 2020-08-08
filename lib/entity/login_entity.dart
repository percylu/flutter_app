import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class LoginEntity with JsonConvert<LoginEntity> {
	int code;
	LoginData data;
	String message;
	bool success;
}

class LoginData with JsonConvert<LoginData> {
	LoginDataUser user;
	String token;
}

class LoginDataUser with JsonConvert<LoginDataUser> {
	String account;
	String avatar;
	String name;
	String qq;
	int sex;
	String status;
	String userId;
	String weibo;
	String weixin;
}
