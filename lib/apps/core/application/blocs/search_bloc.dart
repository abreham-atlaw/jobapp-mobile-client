import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/core/application/events/search_event.dart';
import 'package:jobapp/apps/core/application/states/search_state.dart';
import 'package:jobapp/apps/core/data/repositories/job_repository.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';

class SearchBloc extends AsyncBloc<SearchState> {
  final JobRepository _repository = CoreProviders.provideJobRepositry();

  SearchBloc(super.initialState) {
    on<SearchEvent>(_handleSearch);
  }

  _handleSearch(SearchEvent searchEvent, Emitter emitter) async {
    await asyncCall(
        searchEvent,
        emitter,
        (event, state) async =>
            {this.state.jobs = await _repository.search(searchEvent.query)});
  }
}
