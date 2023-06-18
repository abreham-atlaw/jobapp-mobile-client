import 'package:flutter/widgets.dart';

class Heading extends Text {
  Heading(super.data, double size, {super.key})
      : super(style: TextStyle(fontSize: size, fontWeight: FontWeight.bold));
}

class Heading1 extends Heading {
  Heading1(String data, {super.key}) : super(data, 40);
}


// class Heading2 extends Heading {
//   Heading2(String data, {super.key}) : super(data, 10);
// }


// class Heading1 extends Heading {
//   Heading1(String data, {super.key}) : super(data, 10);
// }


// class Heading1 extends Heading {
//   Heading1(String data, {super.key}) : super(data, 10);
// }
