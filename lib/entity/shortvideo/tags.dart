
class Tags {

  int id;
  String name;
  String actionUrl;
  Object adTrack;
  String desc;
  String bgPicture;
  String headerImage;
  String tagRecType;
  Object childTagList;
  Object childTagIdList;
  int communityIndex;

	Tags.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		actionUrl = map["actionUrl"],
		adTrack = map["adTrack"],
		desc = map["desc"],
		bgPicture = map["bgPicture"],
		headerImage = map["headerImage"],
		tagRecType = map["tagRecType"],
		childTagList = map["childTagList"],
		childTagIdList = map["childTagIdList"],
		communityIndex = map["communityIndex"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['actionUrl'] = actionUrl;
		data['adTrack'] = adTrack;
		data['desc'] = desc;
		data['bgPicture'] = bgPicture;
		data['headerImage'] = headerImage;
		data['tagRecType'] = tagRecType;
		data['childTagList'] = childTagList;
		data['childTagIdList'] = childTagIdList;
		data['communityIndex'] = communityIndex;
		return data;
	}
}
