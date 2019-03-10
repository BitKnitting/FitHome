// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_schema.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activities _$ActivitiesFromJson(Map<String, dynamic> json) {
  return Activities(
      activities: (json['activities'] as List)
          ?.map((e) =>
              e == null ? null : Activity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ActivitiesToJson(Activities instance) =>
    <String, dynamic>{'activities': instance.activities};

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
      name: json['name'] as String,
      icon: json['icon'] as String,
      tip: json['tip'] as String,
      hint: json['hint'] as String,
      checklist: (json['checklist'] as List)
          ?.map((e) =>
              e == null ? null : Checklist.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'name': instance.name,
      'icon': instance.icon,
      'tip': instance.tip,
      'hint': instance.hint,
      'checklist': instance.checklist
    };

Checklist _$ChecklistFromJson(Map<String, dynamic> json) {
  return Checklist(json['todo'] as String, json['url'] as String);
}

Map<String, dynamic> _$ChecklistToJson(Checklist instance) =>
    <String, dynamic>{'todo': instance.todo, 'url': instance.url};
