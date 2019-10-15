
class Shield {

  String itemType;
  int itemId;
  bool shielded;

	Shield.fromJsonMap(Map<String, dynamic> map): 
		itemType = map["itemType"],
		itemId = map["itemId"],
		shielded = map["shielded"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemType'] = itemType;
		data['itemId'] = itemId;
		data['shielded'] = shielded;
		return data;
	}
}
