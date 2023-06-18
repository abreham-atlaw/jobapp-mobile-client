import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/lib/async_bloc/async_events.dart';
import 'package:jobapp/lib/async_bloc/async_handler.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/async_status.dart';
import 'package:jobapp/lib/async_bloc/base_state.dart';

class FunctionalAsyncHandler extends AsyncEventHandler<AsyncEvent, AsyncState> {
  Future<void> Function(AsyncEvent event, AsyncState state) onEventCallback;
  AsyncState Function(AsyncState)? stateGetter;
  Future<void> Function(AsyncEvent event, AsyncState state, dynamic error)?
      onErrorCallback;
  Future<void> Function(AsyncEvent event, AsyncState state)? onLoadingCallback;
  Future<void> Function(AsyncEvent event, AsyncState state)? onDoneCallback;

  FunctionalAsyncHandler(this.onEventCallback, super._parentBloc,
      {this.stateGetter,
      this.onErrorCallback,
      this.onLoadingCallback,
      this.onDoneCallback});

  @override
  onEvent(AsyncEvent event, AsyncState state) async {
    await onEventCallback(event, state);
  }

  @override
  onLoading(AsyncEvent event, AsyncState state) async {
    await super.onLoading(event, state);
    if (onLoadingCallback != null) {
      await onLoadingCallback!(event, state);
    }
  }

  @override
  onDone(AsyncEvent event, AsyncState state) async {
    await super.onDone(event, state);
    if (onDoneCallback != null) {
      await onDoneCallback!(event, state);
    }
  }

  @override
  onError(AsyncEvent event, AsyncState state, error) async {
    await super.onError(event, state, error);
    if (onErrorCallback != null) {
      await onErrorCallback!(event, state, error);
    }
  }
}

class AsyncBloc<S extends BaseState> extends Bloc<AsyncEvent, S> {
  Future<void> onInit() async {}

  Future<void> asyncCall(AsyncEvent event, Emitter emitter,
      Future<void> Function(AsyncEvent event, AsyncState state) onEvent,
      {AsyncState Function(AsyncState)? stateGetter,
      Future<void> Function(AsyncEvent event, AsyncState state, dynamic error)?
          onError,
      Future<void> Function(AsyncEvent event, AsyncState state)? onLoading,
      Future<void> Function(AsyncEvent event, AsyncState state)?
          onDone}) async {
    var handler = FunctionalAsyncHandler(onEvent, this,
        stateGetter: stateGetter,
        onDoneCallback: onDone,
        onLoadingCallback: onLoading,
        onErrorCallback: onError);
    await handler.handle(event, emitter);
  }

  Future<void> initialize(InitializeEvent event, Emitter emitter) async {
    state.initStatus = AsyncStatus.loading;
    emitter.call(state.copy());
    try {
      await onInit();
      state.initStatus = AsyncStatus.done;
      emitter.call(state.copy());
    } catch (ex) {
      state.initStatus = AsyncStatus.failed;
      if (ex is Exception) {
        state.initError = ex;
      } else {
        state.initError = Exception(ex.toString());
      }
      emitter.call(state.copy());
    }
  }

  AsyncBloc(super.initialState) {
    on<InitializeEvent>(initialize);
  }
}
