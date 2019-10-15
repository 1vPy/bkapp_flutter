import 'package:bkapp_flutter/entity/shortvideo/follow.dart';
import 'package:bkapp_flutter/entity/shortvideo/shield.dart';

class Author {

  int id;
  String icon;
  String name;
  String description;
  String link;
  int latestReleaseTime;
  int videoNum;
  Object adTrack;
  Follow follow;
  Shield shield;
  int approvedNotReadyVideoCount;
  bool ifPgc;
  int recSort;
  bool expert;

	Author.fromJsonMap(Map<String, dynamic> map): 
		id = map["id"],
		icon = map["icon"],
		name = map["name"],
		description = map["description"],
		link = map["link"],
		latestReleaseTime = map["latestReleaseTime"],
		videoNum = map["videoNum"],
		adTrack = map["adTrack"],
		follow = Follow.fromJsonMap(map["follow"]),
		shield = Shield.fromJsonMap(map["shield"]),
		approvedNotReadyVideoCount = map["approvedNotReadyVideoCount"],
		ifPgc = map["ifPgc"],
		recSort = map["recSort"],
		expert = map["expert"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['icon'] = icon;
		data['name'] = name;
		data['description'] = description;
		data['link'] = link;
		data['latestReleaseTime'] = latestReleaseTime;
		data['videoNum'] = videoNum;
		data['adTrack'] = adTrack;
		data['follow'] = follow == null ? null : follow.toJson();
		data['shield'] = shield == null ? null : shield.toJson();
		data['approvedNotReadyVideoCount'] = approvedNotReadyVideoCount;
		data['ifPgc'] = ifPgc;
		data['recSort'] = recSort;
		data['expert'] = expert;
		return data;
	}
}
