import 'package:jobapp/apps/auth/data/models/user.dart';

class Worker {
  User user;
  List<String> skills;
  bool isApproved;
  bool hasCredit;
  double credit;

  Worker({
    required this.user,
    required this.skills,
    required this.isApproved,
    required this.credit,
    required this.hasCredit
  });
}
