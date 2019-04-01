// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return Comments(
      comments: (json['comments'] as List)
          ?.map((e) =>
              e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CommentsToJson(Comments instance) =>
    <String, dynamic>{'comments': instance.comments};

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      email: json['email'] as String,
      dateTime: json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      comment: json['comment'] as String);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'email': instance.email,
      'dateTime': instance.dateTime?.toIso8601String(),
      'comment': instance.comment
    };
