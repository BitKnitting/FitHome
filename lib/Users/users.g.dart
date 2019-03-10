// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Users _$UsersFromJson(Map<String, dynamic> json) {
  return Users(
      users: (json['users'] as List)
          ?.map((e) =>
              e == null ? null : User.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$UsersToJson(Users instance) =>
    <String, dynamic>{'users': instance.users};

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      email: json['email'] as String,
      completedActivities: (json['completedActivities'] as List)
          ?.map((e) => e as String)
          ?.toList());
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'completedActivities': instance.completedActivities
    };
