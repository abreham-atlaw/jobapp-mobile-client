import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/application/blocs/choose_skills_bloc.dart';
import 'package:jobapp/apps/auth/application/events/choose_state_event.dart';
import 'package:jobapp/apps/auth/application/states/choose_skill_state.dart';
import 'package:jobapp/apps/core/presentation/widgets/job_type_icon.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/widgets/containers/percentage_container.dart';
import 'package:jobapp/lib/widgets/text/body.dart';

class JobTypeInstance extends StatelessWidget{
  final String jobType;
  final bool isSelected;
  const JobTypeInstance(this.jobType, this.isSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.read<ChooseSkillsBloc>().add(SkillChosenEvent(jobType));
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(SpacingConfigs.spacing1)),
            border: Border.all(
              color: ColorsConfigs.dark,
            ),
            color: ColorsConfigs.white,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(SpacingConfigs.spacing1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    JobTypeIcon(jobType, color: ColorsConfigs.warning, size: FontSizeConfigs.size3,),
                    const SizedBox(height: SpacingConfigs.spacing0),
                    BodyText(jobType, fontWeight: FontWeight.bold, textAlign: TextAlign.center, fontSize: FontSizeConfigs.size0),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isSelected,
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.all(SpacingConfigs.spacing0),
                  decoration: const BoxDecoration(
                    color: ColorsConfigs.success,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: ColorsConfigs.white,
                    size: FontSizeConfigs.size2,
                  ),
                )
              ),
            )
          ],
        ),
      ),
    );
  }

}


class JobTypeGrid extends StatelessWidget{

  final ChooseSkillState _state;

  const JobTypeGrid(this._state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: SpacingConfigs.spacing0,
      children: _state.allSkills!.map<Widget>(
              (jobType) => PercentageContainer(
              width: 0.3,
              child: Padding(
                padding: EdgeInsets.only(top: SpacingConfigs.spacing0),
                child: JobTypeInstance(jobType, _state.isSkillSelected(jobType)),
              )
          )
      ).toList()
    );
  }
}

