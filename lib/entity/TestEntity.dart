import 'package:bkapp_flutter/entity/results.dart';

class TestEntity {

  bool error;
  List<Results> results;

	TestEntity.fromJsonMap(Map<String, dynamic> map):
		error = map["error"],
		results = List<Results>.from(map["results"].map((it) => Results.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['error'] = error;
		data['results'] = results != null ?
			this.results.map((v) => v.toJson()).toList()
			: null;
		return data;
	}


}
