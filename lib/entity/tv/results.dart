
class Results {

  String original_name;
  List<int> genre_ids;
  String name;
	String popularity;
  List<String> origin_country;
  int vote_count;
  String first_air_date;
  String backdrop_path;
  String original_language;
  int id;
  String vote_average;
  String overview;
  String poster_path;

	Results.fromJsonMap(Map<String, dynamic> map): 
		original_name = map["original_name"],
		genre_ids = List<int>.from(map["genre_ids"]),
		name = map["name"],
		popularity = map["popularity"].toString(),
		origin_country = List<String>.from(map["origin_country"]),
		vote_count = map["vote_count"],
		first_air_date = map["first_air_date"],
		backdrop_path = map["backdrop_path"],
		original_language = map["original_language"],
		id = map["id"],
		vote_average = map["vote_average"].toString(),
		overview = map["overview"],
		poster_path = map["poster_path"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['original_name'] = original_name;
		data['genre_ids'] = genre_ids;
		data['name'] = name;
		data['popularity'] = popularity;
		data['origin_country'] = origin_country;
		data['vote_count'] = vote_count;
		data['first_air_date'] = first_air_date;
		data['backdrop_path'] = backdrop_path;
		data['original_language'] = original_language;
		data['id'] = id;
		data['vote_average'] = vote_average;
		data['overview'] = overview;
		data['poster_path'] = poster_path;
		return data;
	}
}
