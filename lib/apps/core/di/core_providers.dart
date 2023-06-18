import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/lib/network/network_client.dart';

import 'package:jobapp/configs/data_configs.dart' as config;

class CoreProviders {
  static NetworkClient? _authenticatedNetworkClient;

  static NetworkClient provideNetworkClient() {
    return NetworkClient(config.apiHost, baseUrl: config.apiBaseUrl);
  }

  static Future<NetworkClient> provideAuthenticatedNetworkClient() async {
    CoreProviders._authenticatedNetworkClient ??= NetworkClient(config.apiHost,
        baseUrl: config.apiBaseUrl,
        token: await AuthProviders.provideTokenStorage().getToken());
    return CoreProviders._authenticatedNetworkClient!;
  }

  static reset() {
    CoreProviders._authenticatedNetworkClient = null;
  }
}
