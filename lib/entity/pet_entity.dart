import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class PetEntity with JsonConvert<PetEntity> {
	int code;
	List<PetData> data;
	String message;
	bool success;
}

class PetData with JsonConvert<PetData> {
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
