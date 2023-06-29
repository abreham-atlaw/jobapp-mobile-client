import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class RoutingUitls {
  static void redirect(String path, BuildContext context, {Object? extra}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.pushReplacement(path, extra: extra);
    });
  }
}
