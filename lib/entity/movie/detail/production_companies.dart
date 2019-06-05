
class Production_companies {

  int id;
  String logo_path;
  String name;
  String origin_country;

	Production_companies.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		logo_path = map["logo_path"],
		name = map["name"],
		origin_country = map["origin_country"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['logo_path'] = logo_path;
		data['name'] = name;
		data['origin_country'] = origin_country;
		return data;
	}
}
