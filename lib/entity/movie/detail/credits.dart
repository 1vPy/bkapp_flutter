import 'package:bkapp_flutter/entity/movie/detail/cast.dart';
import 'package:bkapp_flutter/entity/movie/detail/crew.dart';

class Credits {

  List<Cast> cast;
  List<Crew> crew;

	Credits.fromJsonMap(Map<String, dynamic> map): 
		cast = List<Cast>.from(map["cast"].map((it) => Cast.fromJsonMap(it))),
		crew = List<Crew>.from(map["crew"].map((it) => Crew.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cast'] = cast != null ? 
			this.cast.map((v) => v.toJson()).toList()
			: null;
		data['crew'] = crew != null ? 
			this.crew.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
