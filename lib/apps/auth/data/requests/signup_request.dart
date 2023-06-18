import 'package:jobapp/lib/network/request.dart';

class SignupRequest extends Request<String> {
  SignupRequest(String username, String fullName, String password)
      : super("/auth/signup/",
            postParams: {
              "phone_number": username,
              "full_name": fullName,
              "password": password
            },
            method: Method.post);

  @override
  String deserializeObject(response) {
    return response["token"];
  }
}
