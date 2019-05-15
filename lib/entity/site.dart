
class Site {

  String cat_cn;
  String cat_en;
  String desc;
  String feed_id;
  String icon;
  String id;
  String name;
  int subscribers;
  String type;
  String url;

	Site.fromJsonMap(Map<String, dynamic> map): 
		cat_cn = map["cat_cn"],
		cat_en = map["cat_en"],
		desc = map["desc"],
		feed_id = map["feed_id"],
		icon = map["icon"],
		id = map["id"],
		name = map["name"],
		subscribers = map["subscribers"],
		type = map["type"],
		url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cat_cn'] = cat_cn;
		data['cat_en'] = cat_en;
		data['desc'] = desc;
		data['feed_id'] = feed_id;
		data['icon'] = icon;
		data['id'] = id;
		data['name'] = name;
		data['subscribers'] = subscribers;
		data['type'] = type;
		data['url'] = url;
		return data;
	}
}
