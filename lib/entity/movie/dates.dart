
class Dates {

  String maximum;
  String minimum;

	Dates.fromJsonMap(Map<String, dynamic> map): 
		maximum = map["maximum"],
		minimum = map["minimum"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['maximum'] = maximum;
		data['minimum'] = minimum;
		return data;
	}
}
