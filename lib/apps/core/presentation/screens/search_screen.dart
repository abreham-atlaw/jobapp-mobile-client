import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/core/application/blocs/search_bloc.dart';
import 'package:jobapp/apps/core/application/events/search_event.dart';
import 'package:jobapp/apps/core/application/states/search_state.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/presentation/widgets/job_type_icon.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/forms/text_field_widget.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';

class JobSearchResultInstance extends StatelessWidget {
  Job job;

  JobSearchResultInstance(this.job, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RoutingUitls.redirect("/core/job-map", context, extra: job);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: SpacingConfigs.spacing0),
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(color: ColorsConfigs.grey),
        )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: FontSizeConfigs.size2,
              child: JobTypeIcon(job.jobType, color: ColorsConfigs.dark),
            ),
            SizedBox(width: SpacingConfigs.spacing0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(job.jobType, fontWeight: FontWeight.bold),
                  BodyText(job.location.name)
                ],
              ),
            ),
            BodyText("ETB ${job.wage}")
          ],
        ),
      ),
    );
  }
}

class JobSearchListWidget extends StatelessWidget {
  List<Job> jobs;

  JobSearchListWidget(this.jobs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: jobs.map((Job job) => JobSearchResultInstance(job)).toList(),
      ),
    );
  }
}

class SearchScreen extends AsyncBlocScreen<SearchBloc, SearchState> {
  const SearchScreen({super.key});

  @override
  SearchBloc onCreateBloc(SearchState state) {
    return SearchBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, SearchState state) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SpacingConfigs.spacing1,
          horizontal: SpacingConfigs.spacing1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                  onPressed: () {
                    RoutingUitls.redirect("/", context);
                  },
                  icon: Icon(Icons.arrow_back)),
              Expanded(
                child: RawTextInputWidget(
                    iconData: Icons.search,
                    onChanged: (String value) {
                      context.read<SearchBloc>().add(SearchEvent(value));
                    }),
              )
            ]),
            JobSearchListWidget(state.jobs)
          ],
        ),
      ),
    );
  }

  @override
  SearchState onCreateState() {
    return SearchState();
  }
}
