import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/apps/auth/data/serializers/worker_serializer.dart';
import 'package:jobapp/lib/network/request.dart';

class SignupRequest extends Request<Worker> {
  final WorkerSerializer _serializer = WorkerSerializer();

  SignupRequest(String username, String fullName, String password, List<String> skills)
      : super("/worker/signup/",
            postParams: {
              "user": {
                "username": username,
                "full_name": fullName,
                "password": password,
              },
              "skills": skills
            },
            method: Method.post);

  @override
  Worker deserializeObject(response) {
    return _serializer.deserialize(response);
  }
}
