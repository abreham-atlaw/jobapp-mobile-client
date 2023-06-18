import 'package:jobapp/lib/async_bloc/async_status.dart';

class BaseState {
  AsyncStatus initStatus = AsyncStatus.none;
  Exception? initError;

  BaseState newInstance() {
    return BaseState();
  }

  void copyProperties(BaseState newState) {
    newState.initError = initError;
    newState.initStatus = initStatus;
  }

  BaseState copy() {
    BaseState newState = newInstance();
    copyProperties(newState);
    return newState;
  }
}
