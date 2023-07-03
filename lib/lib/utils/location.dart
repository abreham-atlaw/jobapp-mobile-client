import 'dart:math' as math;
import 'package:jobapp/apps/core/data/models/job.dart';

class LocationUtils{

  static double calcDistance(Location location1, Location location2) {
    const earthRadius = 6371; // Radius of the earth in kilometers
    final lat1 = math.pi / 180.0 * location1.latitude;
    final lon1 = math.pi / 180.0 * location1.longitude;
    final lat2 = math.pi / 180.0 * location2.latitude;
    final lon2 = math.pi / 180.0 * location2.longitude;
    final dLat = lat2 - lat1;
    final dLon = lon2 - lon1;
    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) * math.cos(lat2) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    final distance = earthRadius * c;
    return distance;
  }

}