import 'package:jobapp/apps/auth/data/models/update_info.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class UpdateRequiredState extends BaseState{
  UpdateInfo? info;

  @override
  BaseState newInstance() {
    return UpdateRequiredState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as UpdateRequiredState).info = info;
  }

}