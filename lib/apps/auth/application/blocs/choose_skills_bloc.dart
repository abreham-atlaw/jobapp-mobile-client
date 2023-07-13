



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/application/events/choose_state_event.dart';
import 'package:jobapp/apps/auth/application/states/choose_skill_state.dart';
import 'package:jobapp/apps/core/data/repositories/utils_repository.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';

class ChooseSkillsBloc extends AsyncBloc<ChooseSkillState>{

  final UtilsRepository _repository = CoreProviders.provideUtilsRepository();

  ChooseSkillsBloc(super.initialState){
    on<SkillChosenEvent>(_handleSkillChosen);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();
    state.allSkills = await _repository.getAllJobTypes();
  }

  Future<void> _handleSkillChosen(SkillChosenEvent event, Emitter emitter) async{
    if(state.isSkillSelected(event.skill)){
      state.chosenSkills.remove(event.skill);
    }
    else{
      if(state.chosenSkills.length < ChooseSkillState.maxSkills){
        state.chosenSkills.add(event.skill);
      }
    }
    syncState(emitter);
  }


}