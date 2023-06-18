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

  Future<void> authenticate(String token) async {
    await _tokenStorage.storeToken(token);
  }

  Future<void> login(String username, String password) async {
    await authenticate(
        await _networkClient.execute(LoginRequest(username, password)));
  }

  Future<void> signup(String username, String fullName, String password) async {
    await authenticate(await _networkClient
        .execute(SignupRequest(username, fullName, password)));
  }

  Future<void> logout() async {
    await _tokenStorage.revokeToken();
  }

  Future<AuthenticationStatus> _isAuthenticatedLocally() async {
    if (await _tokenStorage.getToken() != null) {
      return AuthenticationStatus.authenticated;
    }
    return AuthenticationStatus.none;
  }

  Future<AuthenticationStatus> getAuthenticationStatus() async {
    try {
      Worker me = await _networkClient.execute(WhoAmIRequest());
      if (me.isApproved) {
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
