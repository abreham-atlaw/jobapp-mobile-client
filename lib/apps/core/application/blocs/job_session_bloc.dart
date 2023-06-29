import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_session_events.dart';
import 'package:jobapp/apps/core/application/states/job_session_state.dart';
import 'package:jobapp/apps/core/data/repositories/job_repository.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';

class JobSessionBloc extends AsyncBloc<JobSessionState> {
  final JobRepository _repository = CoreProviders.provideJobRepositry();
  late final Timer _timer;

  JobSessionBloc(super.initialState) {
    on<RefreshEvent>(_handleRefresh);
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      add(RefreshEvent());
    });
  }

  @override
  Future<void> onInit() async {
    await super.onInit();
    await _refresh();
  }

  Future<void> _refresh() async {
    state.job = await _repository.getCurrentSession();
  }

  Future<void> _handleRefresh(RefreshEvent event, Emitter emitter) async {
    await _refresh();
    syncState(emitter);
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
