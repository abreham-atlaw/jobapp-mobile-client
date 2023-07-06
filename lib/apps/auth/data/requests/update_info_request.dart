


import 'package:jobapp/apps/auth/data/models/update_info.dart';
import 'package:jobapp/apps/auth/data/serializers/update_info_serializer.dart';
import 'package:jobapp/lib/network/request.dart';

class UpdateInfoRequest extends Request<UpdateInfo>{

  final UpdateInfoSerializer _serializer = UpdateInfoSerializer();

  UpdateInfoRequest() : super("/auth/update-info/", getParams: {"app": "worker"});

  @override
  UpdateInfo deserializeObject(response) {
    return _serializer.deserialize(response);
  }

}