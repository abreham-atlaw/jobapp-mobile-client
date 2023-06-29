import 'package:flutter_map/flutter_map.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class JobMapState extends AsyncState {
  List<Job> jobs = [];
  Location userLocation = Location(latitude: 0, longitude: 0);
  Location searchLocation = Location(latitude: 0, longitude: 0);
  double zoom = 17;
  Job? selectedJob;
  Job? acceptedJob;
  MapController controller = MapController();

  AsyncState jobAcceptState = AsyncState();

  @override
  BaseState newInstance() {
    return JobMapState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as JobMapState).jobs = jobs;
    newState.searchLocation = searchLocation;
    newState.selectedJob = selectedJob;
    newState.zoom = zoom;
    newState.userLocation = userLocation;
    newState.jobAcceptState = jobAcceptState;
    newState.acceptedJob = acceptedJob;
  }
}
