import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jobapp/apps/core/application/blocs/job_map_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_map_events.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:latlong2/latlong.dart';

import 'job_type_icon.dart';

class JobMarker extends Marker {
  JobMarker(Job job, bool isSelected, bool isAccepted, {super.key})
      : super(
            width: WidgetSizeConfigs.size0,
            height: WidgetSizeConfigs.size0,
            point: LatLng(job.location.latitude, job.location.longitude),
            builder: (BuildContext context) {
              return GestureDetector(
                onTap: () =>
                    {context.read<JobMapBloc>().add(JobSelectedEvent(job))},
                child: Container(
                  width: WidgetSizeConfigs.size7,
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorsConfigs.white, width: 1),
                      borderRadius: BorderRadius.circular(100),
                      color: (isAccepted)
                          ? ColorsConfigs.success
                          : (isSelected)
                              ? ColorsConfigs.secondary
                              : ColorsConfigs.primary,
                      boxShadow: const [
                        BoxShadow(
                            color: ColorsConfigs.dark,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(4, 4))
                      ]),
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: WidgetSizeConfigs.size2,
                      child: JobTypeIcon(job.jobType),
                    ),
                  ),
                ),
              );
            });
}
