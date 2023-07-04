import 'package:jobapp/apps/auth/data/models/authentication_status.dart';
import 'package:jobapp/apps/auth/data/models/worker.dart';
import 'package:jobapp/apps/auth/data/requests/login_request.dart';
import 'package:jobapp/apps/auth/data/requests/signup_request.dart';
import 'package:jobapp/apps/auth/data/requests/whoami_request.dart';
import 'package:jobapp/apps/auth/di/auth_providers.dart';
import 'package:jobapp/apps/core/di/core_providers.dart';
import 'package:jobapp/lib/network/network_client.dart';
import 'package:jobapp/lib/utils/token_storage.dart';

class AuthRepository {
  final TokenStorage _tokenStorage = AuthProviders.provideTokenStorage();
  final NetworkClient _networkClient = CoreProviders.provideNetworkClient();

  Future<NetworkClient> get _authenticatedNetworkClient async {
    return await CoreProviders.provideAuthenticatedNetworkClient();
  }

  Future<void> authenticate(String token) async {
    await _tokenStorage.storeToken(token);
  }

  Future<void> login(String username, String password) async {
    await authenticate(
        await _networkClient.execute(LoginRequest(username, password)));
  }

  Future<void> signup(String username, String fullName, String password) async {
    await _networkClient.execute(SignupRequest(username, fullName, password));
    await login(username, password);
  }

  Future<void> logout() async {
    await _tokenStorage.revokeToken();
    AuthProviders.reset();
    CoreProviders.reset();
  }

  Future<AuthenticationStatus> _isAuthenticatedLocally() async {
    if (await _tokenStorage.getToken() != null) {
      return AuthenticationStatus.authenticated;
    }
    return AuthenticationStatus.none;
  }

  Future<Worker> whoAmI() async{
    return await ( await _authenticatedNetworkClient).execute(WhoAmIRequest());
  }

  Future<AuthenticationStatus> getAuthenticationStatus() async {
    try {
      if (await _tokenStorage.getToken() == null) {
        return AuthenticationStatus.none;
      }
      Worker me = await whoAmI();
      if (me.isApproved) {
        if(!me.hasCredit){
          return AuthenticationStatus.lowCredit;
        }
        return AuthenticationStatus.authenticated;
      }
      return AuthenticationStatus.review;
    } catch (ex) {
      if (ex is ApiException && ex.statusCode == 401) {
        return AuthenticationStatus.none;
      }
      return await _isAuthenticatedLocally();
    }
  }
}
