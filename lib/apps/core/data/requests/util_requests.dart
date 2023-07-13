import 'package:jobapp/lib/network/request.dart';

class GetJobTypesRequest extends Request<List<String>>{
  GetJobTypesRequest(): super(
      "/core/jobtypes/",
      method: Method.get
  );

  @override
  List<String> deserializeObject(response) {
    return response.map<String>((val) => val as String).toList();
  }
}