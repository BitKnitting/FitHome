import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activities_schema.g.dart';

@JsonSerializable()
class Activities {
  Activities({
    this.activities,
  });

  final List<Activity> activities;

  factory Activities.fromJson(Map<String, dynamic> json) =>
      _$ActivitiesFromJson(json);

  Map<String, dynamic> toJson() => _$ActivitiesToJson(this);
}

@JsonSerializable()
class Activity {
  Activity(
      {this.name,
      this.icon,
      this.tip,
      this.hint,
      this.checklist});
  final String name;
  final String icon;
  final String tip;
  final String hint;
  final List<Checklist> checklist;

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}

@JsonSerializable()
class Checklist {
  Checklist(this.todo, this.url);
  final String todo;
  final String url;
  factory Checklist.fromJson(Map<String, dynamic> json) =>
      _$ChecklistFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistToJson(this);
}
