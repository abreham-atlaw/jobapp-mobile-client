import 'package:jobapp/apps/auth/data/serializers/user_serializer.dart';
import 'package:jobapp/apps/core/data/models/employer.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class EmployerSerializer extends Serializer<Employer, Map<String, dynamic>> {
  final UserSerializer _userSerializer = UserSerializer();

  @override
  Employer deserialize(Map<String, dynamic> data) {
    return Employer(_userSerializer.deserialize(data["user"])); // TODO
  }

  @override
  Map<String, dynamic> serialize(Employer instance) {
    return {"user": _userSerializer.serialize(instance.user)}; // TODO
  }
}
