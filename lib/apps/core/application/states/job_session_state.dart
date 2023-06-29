import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class JobSessionState extends BaseState {
  Job? job;
  JobSessionState();

  @override
  BaseState newInstance() {
    return JobSessionState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as JobSessionState).job = job;
  }
}
