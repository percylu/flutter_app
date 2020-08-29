import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class PetTypeEntity with JsonConvert<PetTypeEntity> {
	int code;
	List<PetTypeData> data;
	String message;
	bool success;
}

class PetTypeData with JsonConvert<PetTypeData> {
	String createTime;
	String typeId;
	String typeName;
	String updateTime;
}
