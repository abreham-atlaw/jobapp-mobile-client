



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobapp/apps/auth/application/events/update_event.dart';
import 'package:jobapp/apps/auth/application/states/update_required_state.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateRequiredBloc extends AsyncBloc<UpdateRequiredState>{
  AuthRepository _repository = AuthProviders.provideAuthRepository();

  UpdateRequiredBloc(super.initialState){
    on<LaunchUpdateLinkEvent>(_handleLaunchUpdateLink);
  }

  @override
  Future<void> onInit() async{
    await super.onInit();
    state.info = await _repository.getUpdateInfo();
  }

  Future<void> _handleLaunchUpdateLink(LaunchUpdateLinkEvent event, Emitter emitter) async{
    launchUrl(Uri.parse(state.info!.updateUrl));
  }

}