
class Images {

  List<Object> backdrops;
  List<Object> posters;

	Images.fromJsonMap(Map<String, dynamic> map): 
		backdrops = map["backdrops"],
		posters = map["posters"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['backdrops'] = backdrops;
		data['posters'] = posters;
		return data;
	}
}
