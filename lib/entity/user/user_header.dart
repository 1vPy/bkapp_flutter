
class UserHeader {

  String __type;
  String cdn;
  String filename;
  String url;

	UserHeader.fromJsonMap(Map<String, dynamic> map): 
		__type = map["__type"],
		cdn = map["cdn"],
		filename = map["filename"],
		url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['__type'] = __type;
		data['cdn'] = cdn;
		data['filename'] = filename;
		data['url'] = url;
		return data;
	}
}
