import 'package:bkapp_flutter/entity/shortvideo/data.dart';

class ItemList {

  String type;
  Data data;
  Object tag;
  int id;
  int adIndex;

	ItemList.fromJsonMap(Map<String, dynamic> map): 
		type = map["type"],
		data = Data.fromJsonMap(map["data"]),
		tag = map["tag"],
		id = map["id"],
		adIndex = map["adIndex"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data1 = new Map<String, dynamic>();
		data1['type'] = type;
		data1['data'] = data == null ? null : data.toJson();
		data1['tag'] = tag;
		data1['id'] = id;
		data1['adIndex'] = adIndex;
		return data1;
	}
}
