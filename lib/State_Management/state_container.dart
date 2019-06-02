import 'package:fithome/Members/member.dart';
import 'package:flutter/material.dart';

class StateContainer extends InheritedWidget {
  // Provide a way to hook into a child...
  const StateContainer({Key key, Widget child, this.member}) : super(key: key, child: child);
  final Member member;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
  // Provide access to the StateContainer
  static StateContainer of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StateContainer);
  }
}
