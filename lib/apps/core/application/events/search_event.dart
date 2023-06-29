import 'package:jobapp/lib/async_bloc/async_events.dart';

class SearchEvent extends AsyncEvent {
  String query;

  SearchEvent(this.query);
}
