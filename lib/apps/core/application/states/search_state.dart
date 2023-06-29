import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';
import 'package:jobapp/lib/forms/field.dart';

class SearchState extends AsyncState {
  TextField field = TextField();
  List<Job> jobs = [];

  @override
  BaseState newInstance() {
    return SearchState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as SearchState).field = field;
    newState.jobs = jobs;
  }
}
