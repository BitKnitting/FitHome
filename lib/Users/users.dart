import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

//TODO: Clean out if not using.
Future<String> loadUsers() async {
  return await rootBundle.loadString('assets/users.json');
}

@JsonSerializable()
class Users {
  final List<User> users;
  Users({this.users});
  factory Users.fromJson(Map<String, dynamic> json) => _$UsersFromJson(json);

  Map<String, dynamic> toJson() => _$UsersToJson(this);
}

@JsonSerializable()
class User {
  final String email;
  final List<String> completedActivities;

  User({this.email, this.completedActivities});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
