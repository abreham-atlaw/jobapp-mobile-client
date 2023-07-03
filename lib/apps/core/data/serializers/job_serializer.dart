import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/apps/auth/data/serializers/worker_serializer.dart';
import 'package:jobapp/apps/core/data/models/employer.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/data/serializers/employer_serializer.dart';
import 'package:jobapp/apps/core/data/serializers/location_serializer.dart';
import 'package:jobapp/lib/serializers/datetime_serializer.dart';
import 'package:jobapp/lib/serializers/nullable_serializer.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class JobSerializer extends Serializer<Job, Map<String, dynamic>> {
  final EmployerSerializer _employerSerializer = EmployerSerializer();
  final NullableSerializer<Worker, Map<String, dynamic>> _workerSerializer =
      NullableSerializer(WorkerSerializer());
  final NullableSerializer<DateTime, String> _dateTimeSerializer =
      NullableSerializer(DateTimeSerializer());
  final LocationSerializer _locationSerializer = LocationSerializer();

  @override
  Job deserialize(Map<String, dynamic> data) {
    return Job(
        id: data['id'].toString(),
        location: _locationSerializer.deserialize(data["location"]),
        jobType: data['job_type'],
        employer: _employerSerializer.deserialize(data['employer']),
        acceptTime: _dateTimeSerializer.deserialize(data['accept_time']),
        startTime: _dateTimeSerializer.deserialize(data['start_time']),
        requestTime: _dateTimeSerializer.deserialize(data['request_time'])!,
        worker: _workerSerializer.deserialize(data['worker']),
        hasStarted: data['has_started'],
        hasEnded: data['has_ended'],
        isAccepted: data['is_accepted'],
        isActive: data["is_active"]);
  }

  @override
  Map<String, dynamic> serialize(Job instance) {
    return {
      'id': int.parse(instance.id),
      'location': _locationSerializer.serialize(instance.location),
      'job_type': instance.jobType,
      'employer': _employerSerializer.serialize(instance.employer),
      'accept_time': _dateTimeSerializer.serialize(instance.acceptTime),
      'start_time': _dateTimeSerializer.serialize(instance.startTime),
      'request_time': _dateTimeSerializer.serialize(instance.requestTime),
      'worker': _workerSerializer.serialize(instance.worker),
    };
  }
}
