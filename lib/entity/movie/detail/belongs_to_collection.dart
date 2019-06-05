
class Belongs_to_collection {

  int id;
  String name;
  String poster_path;
  String backdrop_path;

	Belongs_to_collection.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		name = map["name"],
		poster_path = map["poster_path"],
		backdrop_path = map["backdrop_path"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['name'] = name;
		data['poster_path'] = poster_path;
		data['backdrop_path'] = backdrop_path;
		return data;
	}
}
