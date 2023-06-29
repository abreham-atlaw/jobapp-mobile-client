import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:latlong2/latlong.dart';

class UserMarker extends Marker {
  UserMarker(Location location)
      : super(
          point: LatLng(location.latitude, location.longitude),
          width: WidgetSizeConfigs.size2,
          height: WidgetSizeConfigs.size2,
          builder: (BuildContext context) {
            return Stack(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: ColorsConfigs.primary, width: 2),
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(128, 0, 171, 239)),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: FontSizeConfigs.size1,
                  height: FontSizeConfigs.size1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: ColorsConfigs.info),
                ),
              ),
            ]);
          },
        );
}
