


import 'package:jobapp/apps/core/data/requests/util_requests.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/network/network_client.dart';

class UtilsRepository{

  final NetworkClient _networkClient = CoreProviders.provideNetworkClient();

  Future<List<String>> getAllJobTypes() async{
    return await _networkClient.execute(GetJobTypesRequest());
  }

}