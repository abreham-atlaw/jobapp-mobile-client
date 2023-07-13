import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/configs/ui_configs.dart';

class JobTypeIcon extends StatelessWidget {
  final String jobType;
  final Color color;
  final double size;

  final Map<String, IconData> iconMap = {
    "construction": Icons.construction,
    "mechanic": Icons.car_repair,
    "electrical installation": Icons.electric_bolt,
    "network installation": Icons.network_cell,
    "day laborer": Icons.construction,
    "satellite dish": Icons.satellite_alt,
    "painter": Icons.color_lens,
    "cleaning services": Icons.cleaning_services,
    "photographer": Icons.camera_alt,
    "security systems installation": Icons.security,
    "computer repair": Icons.computer,
    "carpenter": Icons.carpenter,
    "plumber": Icons.plumbing,
  };

  final IconData defaultIcon = Icons.work;

  JobTypeIcon(this.jobType, {super.key, this.color = ColorsConfigs.white, this.size = FontSizeConfigs.size2});

  IconData _getIconData() {
    return iconMap[jobType.toLowerCase()] ?? defaultIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(_getIconData(), color: color, size: size,);
  }
}
