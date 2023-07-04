import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class LowCreditState extends BaseState{
  Worker? me;

  @override
  BaseState newInstance() {
    return LowCreditState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as LowCreditState).me = me;
  }

}