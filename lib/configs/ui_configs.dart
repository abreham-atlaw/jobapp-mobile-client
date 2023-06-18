import 'dart:ui';

import 'package:loading_indicator/loading_indicator.dart';

class ColorsConfigs {
  static const Color primary = Color.fromARGB(255, 0, 98, 135);
  static const Color primaryDark = Color.fromARGB(255, 0, 90, 124);
  static const Color secondary = Color.fromARGB(255, 255, 85, 0);
  static const Color tertiary = Color.fromARGB(255, 0, 88, 209);
  static const Color light = Color.fromARGB(255, 245, 245, 245);
  static const Color grey = Color.fromARGB(255, 90, 90, 90);
  static const Color danger = Color.fromARGB(255, 202, 0, 0);
  static const Color warning = Color.fromARGB(255, 255, 138, 0);
  static const Color success = Color.fromARGB(255, 0, 175, 7);
  static const Color info = Color.fromARGB(255, 0, 163, 255);
  static const Color white = Color.fromARGB(255, 255, 255, 255);
  static const Color dark = Color.fromARGB(255, 26, 26, 26);
}

class FontSizeConfigs {
  static double size0 = 10;
  static double size1 = size0 * 1.5;
  static double size2 = size1 * 1.5;
  static double size3 = size3 * 1.5;
  static double size4 = size3 * 1.5;
}

class SpacingConfigs {
  static double spacing0 = 10;
  static double spacing1 = spacing0 * 1.5;
  static double spacing2 = spacing1 * 1.5;
  static double spacing3 = spacing2 * 1.5;
  static double spacing4 = spacing3 * 1.5;
  static double spacing5 = spacing4 * 1.5;
}

class WidgetSizeConfigs {
  static double size0 = 50;
  static double size1 = size0 * 1.5;
  static double size2 = size1 * 1.5;
  static double size3 = size2 * 1.5;
  static double size4 = size3 * 1.5;
  static double size5 = size4 * 1.5;
  static double size6 = size5 * 1.5;
  static double size7 = size6 * 1.5;
  static double size8 = size7 * 1.5;
  static double size9 = size8 * 1.5;
  static double size10 = size9 * 1.5;
}

class LoadingIndicatorsConfigs {
  static LoadingIndicator indicatorLight = const LoadingIndicator(
    indicatorType: Indicator.ballBeat,
    colors: [ColorsConfigs.light],
  );
  static LoadingIndicator indicatorDark = const LoadingIndicator(
    indicatorType: Indicator.ballBeat,
    colors: [ColorsConfigs.dark],
  );
}
