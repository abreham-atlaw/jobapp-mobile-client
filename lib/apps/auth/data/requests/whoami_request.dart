import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/apps/auth/data/serializers/worker_serializer.dart';
import 'package:jobapp/lib/network/request.dart';

class WhoAmIRequest extends Request<Worker> {
  final WorkerSerializer _serializer = WorkerSerializer();

  WhoAmIRequest() : super("/worker/me/", method: Method.get);

  @override
  Worker deserializeObject(response) {
    return _serializer.deserialize(response);
  }
}
