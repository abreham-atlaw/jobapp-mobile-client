import 'package:jobapp/apps/auth/application/states/lowcredit_state.dart';
import 'package:jobapp/apps/auth/data/repositories/auth_repository.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/async_bloc/async_bloc.dart';



class LowCreditBloc extends AsyncBloc<LowCreditState>{

  AuthRepository _repository = AuthProviders.provideAuthRepository();

  LowCreditBloc(super.initialState);

  @override
  Future<void> onInit() async{
    await super.onInit();
    state.me = await _repository.whoAmI();
  }

}