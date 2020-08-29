import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class PetDetailEntity with JsonConvert<PetDetailEntity> {
	int code;
	PetDetailData data;
	String message;
	bool success;
}

class PetDetailData with JsonConvert<PetDetailData> {
	String birthday;
	String createTime;
	String imgurls;
	String name;
	String petId;
	String rdid;
	int sexy;
	String type;
	String updateTime;
	String userId;
	int weight;
}
