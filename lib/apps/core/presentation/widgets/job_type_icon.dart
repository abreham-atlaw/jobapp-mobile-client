import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/configs/ui_configs.dart';

class JobTypeIcon extends StatelessWidget {
  final String jobType;
  final Color color;

  final Map<String, IconData> iconMap = {
    "construction": Icons.construction,
    "mechanic": Icons.car_repair
  };

  final IconData defaultIcon = Icons.work;

  JobTypeIcon(this.jobType, {super.key, this.color = ColorsConfigs.white});

  IconData _getIconData() {
    return iconMap[jobType.toLowerCase()] ?? defaultIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(_getIconData(), color: color);
  }
}
