
class Consumption {

  int collectionCount;
  int shareCount;
  int replyCount;

	Consumption.fromJsonMap(Map<String, dynamic> map): 
		collectionCount = map["collectionCount"],
		shareCount = map["shareCount"],
		replyCount = map["replyCount"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['collectionCount'] = collectionCount;
		data['shareCount'] = shareCount;
		data['replyCount'] = replyCount;
		return data;
	}
}
