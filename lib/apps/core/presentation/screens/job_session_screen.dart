import 'package:flutter/material.dart';
import 'package:jobapp/apps/core/application/blocs/job_session_bloc.dart';
import 'package:jobapp/apps/core/application/states/job_session_state.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/serializers/datetime_serializer.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/navigation/link.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class JobSessionDetail extends StatelessWidget {
  final String detailKey;
  final String value;

  const JobSessionDetail(this.detailKey, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BodyText(
          detailKey,
          fontWeight: FontWeight.bold,
        ),
        BodyText(value)
      ],
    );
  }
}

class JobSessionScreen
    extends AsyncBlocScreen<JobSessionBloc, JobSessionState> {
  const JobSessionScreen({super.key});

  @override
  JobSessionBloc onCreateBloc(JobSessionState state) {
    return JobSessionBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, JobSessionState state) {
    if (state.job == null) {
      RoutingUitls.redirect("/", context);
      return SizedBox.shrink();
    }
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SpacingConfigs.spacing4,
                horizontal: SpacingConfigs.spacing1),
            width: double.infinity,
            decoration: BoxDecoration(color: ColorsConfigs.primary),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Heading1(
                  state.job!.jobType,
                  color: ColorsConfigs.white,
                ),
                BodyText("St Michael CMC, Addis Ababa",
                    color: ColorsConfigs.white)
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: SpacingConfigs.spacing0,
                horizontal: SpacingConfigs.spacing1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                    Heading2("Session Details"),
                    SizedBox(
                      height: SpacingConfigs.spacing1,
                    )
                  ] +
                  [
                    ["Employer's Name", state.job!.employer.user.fullName],
                    ["Location", "St Michael CMC, Addis Ababa"],
                    ["Wage", "ETB ${state.job!.wage}"],
                    [
                      "Start Time",
                      DateTimeSerializer().serialize(state.job!.startTime!)
                    ],
                    ["Status", (state.job!.isActive) ? "Active" : "Inactive"]
                  ]
                      .map<Widget>((List<String> detail) => Container(
                          padding: EdgeInsets.symmetric(
                              vertical: SpacingConfigs.spacing1),
                          child: JobSessionDetail(detail[0], detail[1])))
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  JobSessionState onCreateState() {
    return JobSessionState();
  }
}
