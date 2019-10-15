import 'package:bkapp_flutter/entity/shortvideo/tags.dart';
import 'package:bkapp_flutter/entity/shortvideo/consumption.dart';
import 'package:bkapp_flutter/entity/shortvideo/provider.dart';
import 'package:bkapp_flutter/entity/shortvideo/author.dart';
import 'package:bkapp_flutter/entity/shortvideo/cover.dart';
import 'package:bkapp_flutter/entity/shortvideo/web_url.dart';

class Data {

  String dataType;
  int id;
  String title;
  String description;
  String library;
  List<Tags> tags;
  Consumption consumption;
  String resourceType;
  Object slogan;
  Provider provider;
  String category;
  Author author;
  Cover cover;
  String playUrl;
  Object thumbPlayUrl;
  int duration;
  WebUrl webUrl;
  int releaseTime;
  List<Object> playInfo;
  Object campaign;
  Object waterMarks;
  bool ad;
  List<Object> adTrack;
  String type;
  String titlePgc;
  String descriptionPgc;
  String remark;
  bool ifLimitVideo;
  int searchWeight;
  int idx;
  Object shareAdTrack;
  Object favoriteAdTrack;
  Object webAdTrack;
  int date;
  Object promotion;
  Object label;
  List<Object> labelList;
  String descriptionEditor;
  bool collected;
  bool played;
  List<Object> subtitles;
  Object lastViewTime;
  Object playlists;
  Object src;
  Object brandWebsiteInfo;

	Data.fromJsonMap(Map<String, dynamic> map): 
		dataType = map["dataType"],
		id = map["id"],
		title = map["title"],
		description = map["description"],
		library = map["library"],
		tags = List<Tags>.from(map["tags"].map((it) => Tags.fromJsonMap(it))),
		consumption = Consumption.fromJsonMap(map["consumption"]),
		resourceType = map["resourceType"],
		slogan = map["slogan"],
		provider = Provider.fromJsonMap(map["provider"]),
		category = map["category"],
		author = Author.fromJsonMap(map["author"]),
		cover = Cover.fromJsonMap(map["cover"]),
		playUrl = map["playUrl"],
		thumbPlayUrl = map["thumbPlayUrl"],
		duration = map["duration"],
		webUrl = WebUrl.fromJsonMap(map["webUrl"]),
		releaseTime = map["releaseTime"],
		playInfo = map["playInfo"],
		campaign = map["campaign"],
		waterMarks = map["waterMarks"],
		ad = map["ad"],
		adTrack = map["adTrack"],
		type = map["type"],
		titlePgc = map["titlePgc"],
		descriptionPgc = map["descriptionPgc"],
		remark = map["remark"],
		ifLimitVideo = map["ifLimitVideo"],
		searchWeight = map["searchWeight"],
		idx = map["idx"],
		shareAdTrack = map["shareAdTrack"],
		favoriteAdTrack = map["favoriteAdTrack"],
		webAdTrack = map["webAdTrack"],
		date = map["date"],
		promotion = map["promotion"],
		label = map["label"],
		labelList = map["labelList"],
		descriptionEditor = map["descriptionEditor"],
		collected = map["collected"],
		played = map["played"],
		subtitles = map["subtitles"],
		lastViewTime = map["lastViewTime"],
		playlists = map["playlists"],
		src = map["src"],
		brandWebsiteInfo = map["brandWebsiteInfo"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['dataType'] = dataType;
		data['id'] = id;
		data['title'] = title;
		data['description'] = description;
		data['library'] = library;
		data['tags'] = tags != null ? 
			this.tags.map((v) => v.toJson()).toList()
			: null;
		data['consumption'] = consumption == null ? null : consumption.toJson();
		data['resourceType'] = resourceType;
		data['slogan'] = slogan;
		data['provider'] = provider == null ? null : provider.toJson();
		data['category'] = category;
		data['author'] = author == null ? null : author.toJson();
		data['cover'] = cover == null ? null : cover.toJson();
		data['playUrl'] = playUrl;
		data['thumbPlayUrl'] = thumbPlayUrl;
		data['duration'] = duration;
		data['webUrl'] = webUrl == null ? null : webUrl.toJson();
		data['releaseTime'] = releaseTime;
		data['playInfo'] = playInfo;
		data['campaign'] = campaign;
		data['waterMarks'] = waterMarks;
		data['ad'] = ad;
		data['adTrack'] = adTrack;
		data['type'] = type;
		data['titlePgc'] = titlePgc;
		data['descriptionPgc'] = descriptionPgc;
		data['remark'] = remark;
		data['ifLimitVideo'] = ifLimitVideo;
		data['searchWeight'] = searchWeight;
		data['idx'] = idx;
		data['shareAdTrack'] = shareAdTrack;
		data['favoriteAdTrack'] = favoriteAdTrack;
		data['webAdTrack'] = webAdTrack;
		data['date'] = date;
		data['promotion'] = promotion;
		data['label'] = label;
		data['labelList'] = labelList;
		data['descriptionEditor'] = descriptionEditor;
		data['collected'] = collected;
		data['played'] = played;
		data['subtitles'] = subtitles;
		data['lastViewTime'] = lastViewTime;
		data['playlists'] = playlists;
		data['src'] = src;
		data['brandWebsiteInfo'] = brandWebsiteInfo;
		return data;
	}
}
