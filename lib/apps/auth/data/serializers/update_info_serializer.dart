

import 'package:jobapp/apps/auth/data/models/update_info.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class UpdateInfoSerializer extends Serializer<UpdateInfo, Map<String, dynamic>>{
  @override
  UpdateInfo deserialize(Map<String, dynamic> data) {
    return UpdateInfo(updateUrl: data["update_link"]);
  }

  @override
  Map<String, dynamic> serialize(UpdateInfo instance) {
    return {
      "update_link": instance.updateUrl
    };
  }

}