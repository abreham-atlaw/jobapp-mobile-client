import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/lib/async_bloc/async_error.dart';
import 'package:jobapp/lib/network/network_client.dart';
import 'package:meta/meta.dart';

import 'async_state.dart';
import 'async_status.dart';

abstract class AsyncEventHandler<E, S> {
  final Bloc _parentBloc;

  AsyncEventHandler(this._parentBloc);

  @protected
  onEvent(E event, S state);

  @protected
  onDone(E event, S state) async {
    getAsyncState(state).asyncStatus = AsyncStatus.done;
  }

  AsyncError parseError(dynamic error) {
    if (error is AsyncError) {
      return error;
    }
    if (error is ApiException) {
      return AsyncError(error.response?.body ?? "Server Error",
          code: error.statusCode);
    }
    return AsyncError(error.toString());
  }

  @protected
  onError(E event, S state, dynamic error) async {
    getAsyncState(state).asyncStatus = AsyncStatus.failed;
    getAsyncState(state).error = parseError(error);
  }

  @protected
  onLoading(E event, S state) async {
    getAsyncState(state).asyncStatus = AsyncStatus.loading;
  }

  @protected
  S constructState(S oldState, AsyncState asyncState) {
    return asyncState as S;
  }

  @protected
  AsyncState getAsyncState(S state) {
    return state as AsyncState;
  }

  void syncState(Emitter emitter) {
    var newState = _parentBloc.state.copy();
    emitter.call(newState);
  }

  handle(E event, Emitter emitter) async {
    await onLoading(event, _parentBloc.state);
    syncState(emitter);
    try {
      await onEvent(event, _parentBloc.state);
      syncState(emitter);
      await onDone(event, _parentBloc.state);
      syncState(emitter);
    } catch (error) {
      await onError(event, _parentBloc.state, error);
      syncState(emitter);
    }
  }
}
