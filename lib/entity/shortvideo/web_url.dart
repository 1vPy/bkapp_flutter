
class WebUrl {

  String raw;
  String forWeibo;

	WebUrl.fromJsonMap(Map<String, dynamic> map): 
		raw = map["raw"],
		forWeibo = map["forWeibo"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['raw'] = raw;
		data['forWeibo'] = forWeibo;
		return data;
	}
}
