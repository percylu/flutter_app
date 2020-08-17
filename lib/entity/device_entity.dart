import 'package:flutter_app/generated/json/base/json_convert_content.dart';

class DeviceEntity with JsonConvert<DeviceEntity> {
	int code;
	List<DeviceData> data;
	String message;
	bool success;
}

class DeviceData with JsonConvert<DeviceData> {
	String imgUrl;
	int litter;
	String color;
	int rubbish;
	String type;
	String deviceId;
	String userId;
	String deviceSn;
	int tims;
}
