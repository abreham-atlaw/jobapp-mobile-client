import 'package:flutter/material.dart';
import 'package:jobapp/configs/ui_configs.dart';

class BaseButton extends ElevatedButton {
  BaseButton(
      {super.key,
      super.onPressed,
      super.child,
      EdgeInsets? padding,
      Color? textColor,
      Color? backgroundColor})
      : super(
            style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? ColorsConfigs.primary,
                padding: padding ??
                    EdgeInsets.symmetric(
                        vertical: SpacingConfigs.spacing1,
                        horizontal: SpacingConfigs.spacing5),
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SpacingConfigs.spacing3))));
}
