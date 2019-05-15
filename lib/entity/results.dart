import 'package:bkapp_flutter/entity/site.dart';

class Results {

  String _id;
  String content;
  String cover;
  int crawled;
  String created_at;
  bool deleted;
  String published_at;
  String raw;
  Site site;
  String title;
  String uid;
  String url;

	Results.fromJsonMap(Map<String, dynamic> map): 
		_id = map["_id"],
		content = map["content"],
		cover = map["cover"],
		crawled = map["crawled"],
		created_at = map["created_at"],
		deleted = map["deleted"],
		published_at = map["published_at"],
		raw = map["raw"],
		site = Site.fromJsonMap(map["site"]),
		title = map["title"],
		uid = map["uid"],
		url = map["url"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = _id;
		data['content'] = content;
		data['cover'] = cover;
		data['crawled'] = crawled;
		data['created_at'] = created_at;
		data['deleted'] = deleted;
		data['published_at'] = published_at;
		data['raw'] = raw;
		data['site'] = site == null ? null : site.toJson();
		data['title'] = title;
		data['uid'] = uid;
		data['url'] = url;
		return data;
	}
}
