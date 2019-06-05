import 'package:bkapp_flutter/entity/movie/detail/belongs_to_collection.dart';
import 'package:bkapp_flutter/entity/movie/detail/genres.dart';
import 'package:bkapp_flutter/entity/movie/detail/production_companies.dart';
import 'package:bkapp_flutter/entity/movie/detail/production_countries.dart';
import 'package:bkapp_flutter/entity/movie/detail/spoken_languages.dart';
import 'package:bkapp_flutter/entity/movie/detail/credits.dart';
import 'package:bkapp_flutter/entity/movie/detail/images.dart';

class MovieDetail {
  bool adult;
  String backdrop_path;
//  Belongs_to_collection belongs_to_collection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdb_id;
  String original_language;
  String original_title;
  String overview;
  double popularity;
  String poster_path;
  List<Production_companies> production_companies;
  List<Production_countries> production_countries;
  String release_date;
  int revenue;
  int runtime;
  List<Spoken_languages> spoken_languages;
  String status;
  String tagline;
  String title;
  bool video;
  String vote_average;
  int vote_count;
  Credits credits;
  Images images;

	MovieDetail.fromJsonMap(Map<String, dynamic> map): 
		adult = map["adult"],
		backdrop_path = map["backdrop_path"],
//		belongs_to_collection = Belongs_to_collection.fromJsonMap(map["belongs_to_collection"]),
		budget = map["budget"],
		genres = List<Genres>.from(map["genres"].map((it) => Genres.fromJsonMap(it))),
		homepage = map["homepage"],
		id = map["id"],
		imdb_id = map["imdb_id"],
		original_language = map["original_language"],
		original_title = map["original_title"],
		overview = map["overview"],
		popularity = map["popularity"],
		poster_path = map["poster_path"],
		production_companies = List<Production_companies>.from(map["production_companies"].map((it) => Production_companies.fromJsonMap(it))),
		production_countries = List<Production_countries>.from(map["production_countries"].map((it) => Production_countries.fromJsonMap(it))),
		release_date = map["release_date"],
		revenue = map["revenue"],
		runtime = map["runtime"],
		spoken_languages = List<Spoken_languages>.from(map["spoken_languages"].map((it) => Spoken_languages.fromJsonMap(it))),
		status = map["status"],
		tagline = map["tagline"],
		title = map["title"],
		video = map["video"],
		vote_average = map["vote_average"].toString(),
		vote_count = map["vote_count"],
		credits = Credits.fromJsonMap(map["credits"]),
		images = Images.fromJsonMap(map["images"]);

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['adult'] = adult;
		data['backdrop_path'] = backdrop_path;
//		data['belongs_to_collection'] = belongs_to_collection == null ? null : belongs_to_collection.toJson();
		data['budget'] = budget;
		data['genres'] = genres != null ? 
			this.genres.map((v) => v.toJson()).toList()
			: null;
		data['homepage'] = homepage;
		data['id'] = id;
		data['imdb_id'] = imdb_id;
		data['original_language'] = original_language;
		data['original_title'] = original_title;
		data['overview'] = overview;
		data['popularity'] = popularity;
		data['poster_path'] = poster_path;
		data['production_companies'] = production_companies != null ? 
			this.production_companies.map((v) => v.toJson()).toList()
			: null;
		data['production_countries'] = production_countries != null ? 
			this.production_countries.map((v) => v.toJson()).toList()
			: null;
		data['release_date'] = release_date;
		data['revenue'] = revenue;
		data['runtime'] = runtime;
		data['spoken_languages'] = spoken_languages != null ? 
			this.spoken_languages.map((v) => v.toJson()).toList()
			: null;
		data['status'] = status;
		data['tagline'] = tagline;
		data['title'] = title;
		data['video'] = video;
		data['vote_average'] = vote_average;
		data['vote_count'] = vote_count;
		data['credits'] = credits == null ? null : credits.toJson();
		data['images'] = images == null ? null : images.toJson();
		return data;
	}

}
