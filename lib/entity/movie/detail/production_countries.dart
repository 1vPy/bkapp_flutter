
class Production_countries {

  String iso_3166_1;
  String name;

	Production_countries.fromJsonMap(Map<String, dynamic> map): 
		iso_3166_1 = map["iso_3166_1"],
		name = map["name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['iso_3166_1'] = iso_3166_1;
		data['name'] = name;
		return data;
	}
}
