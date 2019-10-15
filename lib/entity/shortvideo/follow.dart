
class Follow {

  String itemType;
  int itemId;
  bool followed;

	Follow.fromJsonMap(Map<String, dynamic> map): 
		itemType = map["itemType"],
		itemId = map["itemId"],
		followed = map["followed"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemType'] = itemType;
		data['itemId'] = itemId;
		data['followed'] = followed;
		return data;
	}
}
