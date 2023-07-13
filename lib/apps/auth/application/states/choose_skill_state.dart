

import 'package:jobapp/lib/async_bloc/base_state.dart';

class ChooseSkillState extends BaseState{

  static const int maxSkills = 3;


  List<String>? allSkills;
  List<String> chosenSkills = [];

  bool isSkillSelected(String skill){
    return chosenSkills.contains(skill);
  }

  @override
  BaseState newInstance() {
    return ChooseSkillState();
  }

  @override
  void copyProperties(BaseState newState) {
    super.copyProperties(newState);
    (newState as ChooseSkillState).allSkills = allSkills;
    newState.chosenSkills = chosenSkills;
  }

}