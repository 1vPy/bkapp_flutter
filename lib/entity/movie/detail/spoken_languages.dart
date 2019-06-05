
class Spoken_languages {

  String iso_639_1;
  String name;

	Spoken_languages.fromJsonMap(Map<String, dynamic> map): 
		iso_639_1 = map["iso_639_1"],
		name = map["name"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['iso_639_1'] = iso_639_1;
		data['name'] = name;
		return data;
	}
}
