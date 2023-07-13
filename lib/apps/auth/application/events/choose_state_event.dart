


import 'package:jobapp/lib/async_bloc/async_events.dart';

class ChooseStateEvent extends AsyncEvent{

}

class SkillChosenEvent extends ChooseStateEvent{
  String skill;
  SkillChosenEvent(this.skill);
}