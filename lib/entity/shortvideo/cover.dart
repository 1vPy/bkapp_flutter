
class Cover {

  String feed;
  String detail;
  String blurred;
  Object sharing;
  Object homepage;

	Cover.fromJsonMap(Map<String, dynamic> map): 
		feed = map["feed"],
		detail = map["detail"],
		blurred = map["blurred"],
		sharing = map["sharing"],
		homepage = map["homepage"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['feed'] = feed;
		data['detail'] = detail;
		data['blurred'] = blurred;
		data['sharing'] = sharing;
		data['homepage'] = homepage;
		return data;
	}
}
