import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/apps/core/data/repositories/job_repository.dart';
import 'package:jobapp/apps/core/data/repositories/utils_repository.dart';
import 'package:jobapp/lib/network/network_client.dart';

import 'package:jobapp/configs/data_configs.dart' as config;
import 'package:package_info_plus/package_info_plus.dart';

class CoreProviders {
  static NetworkClient? _authenticatedNetworkClient;

  static NetworkClient provideNetworkClient() {
    return NetworkClient(config.apiHost, baseUrl: config.apiBaseUrl);
  }

  static Future<NetworkClient> provideAuthenticatedNetworkClient() async {
    CoreProviders._authenticatedNetworkClient ??= NetworkClient(config.apiHost,
        baseUrl: config.apiBaseUrl,
        clientVersion: await CoreProviders.provideClientVersion(),
        token: await AuthProviders.provideTokenStorage().getToken());
    return CoreProviders._authenticatedNetworkClient!;
  }

  static JobRepository provideJobRepositry() {
    return JobRepository();
  }

  static Future<String> provideClientVersion() async{
    return (await PackageInfo.fromPlatform()).version;
  }

  static UtilsRepository provideUtilsRepository(){
    return UtilsRepository();
  }

  static reset() {
    CoreProviders._authenticatedNetworkClient = null;
  }
}
