import 'package:bkapp_flutter/entity/user/user_header.dart';

class UserEntity {

  String createdAt;
  String mobilePhoneNumber;
  bool mobilePhoneNumberVerified;
  String objectId;
  String sessionToken;
  String updatedAt;
  UserHeader userHeader;
  String username;

	UserEntity.fromJsonMap(Map<String, dynamic> map):
		createdAt = map["createdAt"],
		mobilePhoneNumber = map["mobilePhoneNumber"],
		mobilePhoneNumberVerified = map["mobilePhoneNumberVerified"],
		objectId = map["objectId"],
		sessionToken = map["sessionToken"],
		updatedAt = map["updatedAt"],
		userHeader = UserHeader.fromJsonMap(map["userHeader"]),
		username = map["username"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createdAt'] = createdAt;
		data['mobilePhoneNumber'] = mobilePhoneNumber;
		data['mobilePhoneNumberVerified'] = mobilePhoneNumberVerified;
		data['objectId'] = objectId;
		data['sessionToken'] = sessionToken;
		data['updatedAt'] = updatedAt;
		data['userHeader'] = userHeader == null ? null : userHeader.toJson();
		data['username'] = username;
		return data;
	}
}
