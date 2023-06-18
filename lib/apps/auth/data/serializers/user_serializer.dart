import 'package:jobapp/apps/auth/data/models/user.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class UserSerializer extends Serializer<User, Map<String, dynamic>> {
  @override
  User deserialize(Map<String, dynamic> data) {
    return User(phoneNumber: data["phone_number"], fullName: data["full_name"]);
  }

  @override
  Map<String, dynamic> serialize(User instance) {
    return {
      "phone_number": instance.phoneNumber,
      "full_name": instance.fullName
    };
  }
}
