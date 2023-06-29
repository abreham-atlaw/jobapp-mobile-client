import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jobapp/apps/core/application/blocs/job_map_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_map_events.dart';
import 'package:jobapp/apps/core/application/states/job_map_state.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/presentation/widgets/job_map_action_widget.dart';
import 'package:jobapp/apps/core/presentation/widgets/job_map_widget.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:latlong2/latlong.dart';

class JobMapScreen extends AsyncBlocScreen<JobMapBloc, JobMapState> {
  final Job? selectedJob;

  const JobMapScreen({super.key, this.selectedJob});
  @override
  JobMapBloc onCreateBloc(JobMapState state) {
    return JobMapBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, JobMapState state) {
    if (state.acceptedJob != null && state.acceptedJob!.hasStarted) {
      RoutingUitls.redirect("/core/session/", context);
    }

    return Stack(children: [
      JobMapWidget(state),
      Positioned(
        top: 10,
        left: 10,
        child: FloatingActionButton(
            backgroundColor: ColorsConfigs.light,
            onPressed: () {
              RoutingUitls.redirect("/core/settings/", context);
            },
            child: const Icon(Icons.menu, color: ColorsConfigs.primary)),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: PercentageContainer(
          height: 0.4,
          width: 100,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(SpacingConfigs.spacing0),
                  child: FloatingActionButton(
                      backgroundColor: ColorsConfigs.light,
                      onPressed: () {
                        context
                            .read<JobMapBloc>()
                            .add(FocusOnUserLocationEvent());
                      },
                      child: const Icon(
                        Icons.gps_fixed,
                        color: ColorsConfigs.primary,
                      )),
                ),
              ),
              Expanded(child: JobMapActionWidget(state)),
            ],
          ),
        ),
      )
    ]);
  }

  @override
  JobMapState onCreateState() {
    var state = JobMapState();
    if (selectedJob != null) {
      state.selectedJob = selectedJob;
    }
    return state;
  }
}
