import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:jobapp/apps/core/application/blocs/job_map_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_map_events.dart';
import 'package:jobapp/apps/core/application/states/job_map_state.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/presentation/widgets/job_marker.dart';
import 'package:jobapp/apps/core/presentation/widgets/user_marker.dart';
import 'package:latlong2/latlong.dart';

class JobMapWidget extends StatelessWidget {
  JobMapState state;
  final MapController _mapController = MapController();

  JobMapWidget(this.state, {super.key});

  List<Marker> _constructMarkers(JobMapState state) {
    List<Marker> markers = [];

    markers.add(UserMarker(state.userLocation));
    markers.addAll(state.jobs
        .map<Marker>((Job job) =>
            JobMarker(job, job == state.selectedJob, job == state.acceptedJob))
        .toList());
    if (state.acceptedJob != null) {
      markers.add(JobMarker(state.acceptedJob!, false, true));
    }

    return markers;
  }

  double calcDistance(Location l1, Location l2) {
    Distance distance = Distance();
    return distance.distance(
        LatLng(l1.latitude, l1.longitude), LatLng(l2.latitude, l2.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: state.controller,
      options: MapOptions(
        center: LatLng(
            state.searchLocation.latitude, state.searchLocation.longitude),
        zoom: state.zoom,
        onPositionChanged: (position, hasGesture) {
          Location newLocation = Location(
              latitude: position.center?.latitude ?? 0.0,
              longitude: position.center?.longitude ?? 0.0);

          if (calcDistance(state.searchLocation, newLocation) < 100000) {
            return;
          }
          context.read<JobMapBloc>().add(SearchLocationChangedEvent(
              Location(
                  latitude: position.center?.latitude ?? 0.0,
                  longitude: position.center?.longitude ?? 0.0),
              position.zoom ?? 15.0));
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(
          markers: _constructMarkers(state),
        )
      ],
    );
  }
}
