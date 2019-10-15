
class Provider {

  String name;
  String alias;
  String icon;

	Provider.fromJsonMap(Map<String, dynamic> map): 
		name = map["name"],
		alias = map["alias"],
		icon = map["icon"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = name;
		data['alias'] = alias;
		data['icon'] = icon;
		return data;
	}
}
