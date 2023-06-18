import 'package:jobapp/apps/auth/data/models/user.dart';

class Worker {
  User user;
  List<String> skills;
  bool isApproved;

  Worker({required this.user, required this.skills, required this.isApproved});
}
