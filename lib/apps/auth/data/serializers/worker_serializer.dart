import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/apps/auth/data/serializers/user_serializer.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class WorkerSerializer extends Serializer<Worker, Map<String, dynamic>> {
  final UserSerializer _userSerializer = UserSerializer();
  @override
  Worker deserialize(Map<String, dynamic> data) {
    return Worker(
        user: _userSerializer.deserialize(data["user"]),
        skills: data["skills"]
            .map<String>((dynamic skill) => skill.toString())
            .toList(),
        isApproved: data["is_approved"]);
  }

  @override
  Map<String, dynamic> serialize(Worker instance) {
    return {
      "user": _userSerializer.serialize(instance.user),
      "skills": instance.skills,
      "is_approved": instance.isApproved
    };
  }
}
