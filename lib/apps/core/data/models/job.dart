import 'package:equatable/equatable.dart';
import 'package:jobapp/apps/auth/data/models/worker.dart';

import 'employer.dart';

class Location {
  double latitude;
  double longitude;
  String name;

  Location({required this.latitude, required this.longitude, this.name = ""});
}

class Job extends Equatable {
  String id;
  Location location;
  String jobType;
  double wage;
  Employer employer;
  DateTime? acceptTime;
  DateTime? startTime;
  DateTime requestTime;
  Worker? worker;
  bool hasStarted;
  bool hasEnded;
  bool isAccepted;
  bool isActive;

  Job(
      {required this.id,
      required this.location,
      required this.jobType,
      required this.wage,
      required this.employer,
      this.acceptTime,
      this.startTime,
      required this.requestTime,
      this.worker,
      required this.hasStarted,
      required this.hasEnded,
      required this.isAccepted,
      required this.isActive});

  @override
  List<Object?> get props => [id];
}
