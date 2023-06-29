import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/lib/serializers/serializer.dart';

class LocationSerializer extends Serializer<Location, dynamic> {
  @override
  Location deserialize(dynamic data) {
    return Location(
        latitude: data["coordinates"][0],
        longitude: data["coordinates"][1],
        name: data["name"]);
  }

  @override
  dynamic serialize(Location instance) {
    return [instance.latitude, instance.longitude];
  }
}
