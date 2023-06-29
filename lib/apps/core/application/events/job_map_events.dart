import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/lib/async_bloc/async_events.dart';

class JobMapEvent extends AsyncEvent {}

class SearchLocationChangedEvent extends JobMapEvent {
  Location newLocation;
  double zoom;
  SearchLocationChangedEvent(this.newLocation, this.zoom);
}

class JobSelectedEvent extends JobMapEvent {
  Job? job;
  JobSelectedEvent(this.job);
}

class JobAcceptEvent extends JobMapEvent {
  Job job;
  JobAcceptEvent(this.job);
}

class DialNumberEvent extends JobMapEvent {
  String number;
  DialNumberEvent(this.number);
}

class RefreshEvent extends JobMapEvent {}

class FocusOnUserLocationEvent extends JobMapEvent {}
