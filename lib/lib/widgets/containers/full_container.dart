import 'package:flutter/material.dart';

import 'wrap_container.dart';

class FullContainer extends StatelessWidget {
  Widget child;
  BoxDecoration? decoration;
  Alignment alignment;

  FullContainer(
      {required this.child,
      this.decoration,
      this.alignment: Alignment.center,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        decoration: decoration,
        child: Align(
          alignment: alignment,
          child: WrapContainer(child: child),
        ),
      ),
    );
  }
}
