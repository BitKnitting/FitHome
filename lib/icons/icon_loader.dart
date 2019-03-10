import 'package:flutter/material.dart';
import 'custom_icons.dart';

const IconsMap = {
  'power': Icons.power,
  'sheep': CustomIcons.sheep,
  'clipboard': CustomIcons.clipboard,
};
IconData getIcon({String name}) {
  if (IconsMap[name] != null) {
    return IconsMap[name];
  } else {
    return null;
  }
}
