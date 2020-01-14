import 'package:bkapp_flutter/entity/shortvideo/item_list.dart';

class ShortVideoList {

  List<ItemList> itemList;
  int count;
  int total;
  String nextPageUrl;
  bool adExist;

	ShortVideoList.fromJsonMap(Map<String, dynamic> map): 
		itemList = List<ItemList>.from(map["itemList"].map((it) => ItemList.fromJsonMap(it))),
		count = map["count"],
		total = map["total"],
		nextPageUrl = map["nextPageUrl"],
		adExist = map["adExist"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemList'] = itemList != null ? 
			this.itemList.map((v) => v.toJson()).toList()
			: null;
		data['count'] = count;
		data['total'] = total;
		data['nextPageUrl'] = nextPageUrl;
		data['adExist'] = adExist;
		return data;
	}
}
