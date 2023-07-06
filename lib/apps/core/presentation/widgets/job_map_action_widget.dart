import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/apps/core/application/blocs/job_map_bloc.dart';
import 'package:jobapp/apps/core/application/events/job_map_events.dart';
import 'package:jobapp/apps/core/application/states/job_map_state.dart';
import 'package:jobapp/apps/core/data/models/job.dart';
import 'package:jobapp/apps/core/presentation/screens/search_screen.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/async_bloc/async_state.dart';
import 'package:jobapp/lib/async_bloc/async_status.dart';
import 'package:jobapp/lib/forms/field.dart';
import 'package:jobapp/lib/utils/location.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/async_button.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/forms/text_field_widget.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';
import 'package:url_launcher/url_launcher.dart';

class JobSearchActionWidget extends StatelessWidget {
  final List<Job> jobs;

  const JobSearchActionWidget(this.jobs, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextFieldWidget(
            onTap: () {
              RoutingUitls.redirect("/core/search", context);
            },
            field: Field<String>(),
            iconData: Icons.search,
          ),
          JobSearchListWidget(jobs)
        ],
      ),
    );
  }
}

class JobDetailWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final Color background;

  const JobDetailWidget(this.icon, this.title, this.body, this.background,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SpacingConfigs.spacing2,
          horizontal: SpacingConfigs.spacing0),
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(SpacingConfigs.spacing1)),
          color: background),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: ColorsConfigs.white,
            size: FontSizeConfigs.size3,
          ),
          BodyText(title,
              fontWeight: FontWeight.bold, color: ColorsConfigs.white),
          BodyText(
            body,
            color: ColorsConfigs.white,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class JobDetailActionWidget extends StatelessWidget {
  final Job job;
  final AsyncState state;
  final Location userLocation;

  JobDetailActionWidget(this.job, this.state, this.userLocation);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(children: [
          Builder(builder: (context) {
            if (job.isAccepted) {
              return SizedBox.shrink();
            }
            return IconButton(
                onPressed: () {
                  context.read<JobMapBloc>().add(JobSelectedEvent(null));
                },
                icon: Icon(Icons.arrow_back));
          }),
          Expanded(
            child: BodyText(
              job.jobType,
              fontSize: FontSizeConfigs.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          Builder(builder: (BuildContext context) {
            if (job.isAccepted) {
              return BaseButton(
                backgroundColor: ColorsConfigs.primary,
                padding: EdgeInsets.symmetric(
                    vertical: SpacingConfigs.spacing0,
                    horizontal: SpacingConfigs.spacing1),
                onPressed: () {
                  context
                      .read<JobMapBloc>()
                      .add(DialNumberEvent(job.employer.user.phoneNumber));
                },
                child: Row(
                  children: [
                    Icon(Icons.phone, color: ColorsConfigs.white),
                    BodyText(
                      job.employer.user.phoneNumber,
                      color: ColorsConfigs.white,
                    )
                  ],
                ),
              );
            }
            if (state.asyncStatus == AsyncStatus.done) {
              return SizedBox.shrink();
            }
            return AsyncButton(
              state: state,
              label: "Accept",
              padding: EdgeInsets.symmetric(
                  vertical: SpacingConfigs.spacing0,
                  horizontal: SpacingConfigs.spacing2),
              backgroundColor: ColorsConfigs.success,
              onPressed: () {
                context.read<JobMapBloc>().add(JobAcceptEvent(job));
              },
            );
          })
        ]),
        SizedBox(
          height: SpacingConfigs.spacing1,
        ),
        Expanded(
          child: Row(
            children: [
              [
                Icons.person_outline,
                "Employer",
                job.employer.user.fullName,
                ColorsConfigs.primary
              ],
              [
                Icons.location_pin,
                "Location",
                job.location.name,
                ColorsConfigs.secondary
              ],
              [
                Icons.money,
                "Distance",
                "${LocationUtils.calcDistance(userLocation, job.location).toStringAsFixed(2)} KM",
                ColorsConfigs.danger
              ]
            ]
                .map<Widget>((List<dynamic> data) => Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SpacingConfigs.spacing0),
                        child: JobDetailWidget(
                            data[0] as IconData,
                            data[1] as String,
                            data[2] as String,
                            data[3] as Color),
                      ),
                    ))
                .toList(),
          ),
        ),
        SizedBox(
          height: SpacingConfigs.spacing1,
        ),
      ]),
    );
  }
}

class JobMapActionWidget extends StatelessWidget {
  final JobMapState state;

  const JobMapActionWidget(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(SpacingConfigs.spacing3,
          SpacingConfigs.spacing2, SpacingConfigs.spacing3, 0),
      decoration: BoxDecoration(
          color: ColorsConfigs.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(SpacingConfigs.spacing4))),
      child: Builder(builder: (BuildContext context) {
        if (state.selectedJob == null) {
          return JobSearchActionWidget(state.jobs);
        }
        return JobDetailActionWidget(state.selectedJob!, state.jobAcceptState, state.userLocation);
      }),
    );
  }
}
