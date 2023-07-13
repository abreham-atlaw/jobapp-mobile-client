import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:jobapp/apps/auth/application/blocs/choose_skills_bloc.dart';
import 'package:jobapp/apps/auth/application/states/choose_skill_state.dart';
import 'package:jobapp/apps/auth/presentation/widgets/job_type_grid.dart';
import 'package:jobapp/configs/ui_configs.dart';
import 'package:jobapp/lib/utils/routing.dart';
import 'package:jobapp/lib/widgets/buttons/base_button.dart';
import 'package:jobapp/lib/widgets/screens/bloc_screen.dart';
import 'package:jobapp/lib/widgets/text/body.dart';
import 'package:jobapp/lib/widgets/text/headers.dart';

class ChooseSkillsScreen extends AsyncBlocScreen<ChooseSkillsBloc, ChooseSkillState>{
  const ChooseSkillsScreen({super.key});

  @override
  ChooseSkillsBloc onCreateBloc(ChooseSkillState state) {
    return ChooseSkillsBloc(state);
  }

  @override
  Widget onCreateMain(BuildContext context, ChooseSkillState state) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: SpacingConfigs.spacing2,),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: SpacingConfigs.spacing1,
                  horizontal: SpacingConfigs.spacing1
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Heading3("Choose Skill"),
                    BodyText(
                      "${state.chosenSkills.length} of 3 Selected",
                      fontWeight: FontWeight.bold
                    )
                  ],
                ),
              ),
              JobTypeGrid(state),
              const SizedBox(height: WidgetSizeConfigs.size2)

            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(SpacingConfigs.spacing3),
            child: BaseButton(
              onPressed: (){
                RoutingUitls.redirect("/auth/signup-form", context, extra: state.chosenSkills);
              },
              child: BodyText("NEXT", color: ColorsConfigs.white),
            ),
          ),
        )
      ],
    );
  }

  @override
  ChooseSkillState onCreateState() {
    return ChooseSkillState();
  }
  
}