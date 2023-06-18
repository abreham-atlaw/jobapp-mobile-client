import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:jobapp/configs/ui_configs.dart';

class BodyText extends Text {
  BodyText(text,
      {super.key, double? fontSize, Color? color, FontWeight? fontWeight})
      : super(text,
            style: TextStyle(
                color: color ?? ColorsConfigs.dark,
                fontSize: fontSize ?? FontSizeConfigs.size1,
                decoration: TextDecoration.none,
                fontWeight: fontWeight));
}
