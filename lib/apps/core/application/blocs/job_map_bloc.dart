import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_map_events.dart';
import 'package:jobapp/apps/core/application/states/job_map_state.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/data/repositories/job_repository.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class JobMapBloc extends AsyncBloc<JobMapState> {
  final _fetchInterval = 5;

  final JobRepository _jobRepository = CoreProviders.provideJobRepositry();
  late final Timer _timer;

  JobMapBloc(super.initialState) {
    on<SearchLocationChangedEvent>(_handleLocationChange);
    on<JobSelectedEvent>(_handleJobSelected);
    on<JobAcceptEvent>(_handleJobAccept);
    on<DialNumberEvent>(_handleDialNumber);
    on<RefreshEvent>(_handleRefresh);
    on<FocusOnUserLocationEvent>(_handleFocusOnUserLocation);

    _timer = Timer.periodic(Duration(seconds: _fetchInterval), (_) {
      add(RefreshEvent());
    });
  }

  Future<Location> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Location(latitude: 0, longitude: 0);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Location(latitude: 0, longitude: 0);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Location(latitude: 0, longitude: 0);
    }

    Position position = await Geolocator.getCurrentPosition();
    return Location(latitude: position.latitude, longitude: position.longitude);
  }

  @override
  Future<void> onInit() async {
    await super.onInit();
    await _refreshState();
    state.searchLocation = state.userLocation;
    if (state.acceptedJob != null) {
      state.selectedJob = state.acceptedJob;
    }
    if (state.selectedJob != null) {
      state.searchLocation = state.selectedJob!.location;
    }
  }

  Future<void> _refreshState() async {
    state.userLocation = await _getLocation();
    state.acceptedJob = await _jobRepository.getCurrentSession();
    state.jobs = await _jobRepository.listJobs(state.searchLocation);
  }

  Future<void> _handleLocationChange(
      SearchLocationChangedEvent event, Emitter emitter) async {
    await asyncCall(
        event,
        emitter,
        (newEvent, state) async => {
              this.state.jobs = await _jobRepository.listJobs(event.newLocation)
            });
  }

  Future<void> _handleJobSelected(
      JobSelectedEvent event, Emitter emitter) async {
    state.selectedJob = event.job;
    syncState(emitter);
  }

  Future<void> _handleJobAccept(JobAcceptEvent event, Emitter emitter) async {
    await asyncCall(
      event,
      emitter,
      (_, __) async {
        await _jobRepository.acceptJob(event.job);
        await _refreshState();
        state.selectedJob = state.acceptedJob;
      },
      stateGetter: (p0) {
        return state.jobAcceptState;
      },
    );
  }

  Future<void> _handleDialNumber(DialNumberEvent event, Emitter emitter) async {
    await launchUrl(Uri.parse("tel:${event.number}"));
  }

  Future<void> _handleRefresh(RefreshEvent event, Emitter emitter) async {
    await _refreshState();
    syncState(emitter);
  }

  Future<void> _handleFocusOnUserLocation(
      FocusOnUserLocationEvent event, Emitter emitter) async {
    state.searchLocation = state.userLocation;
    state.controller.move(
        LatLng(state.userLocation.latitude, state.userLocation.longitude),
        state.zoom);
    syncState(emitter);
  }

  @override
  Future<void> close() async {
    _timer.cancel();
    super.close();
  }
}
