import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

enum AuthState { authenticated, unauthenticated, loading }

class AuthController extends GetxController {
  final Rx<AuthState> _authState = AuthState.unauthenticated.obs;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  AuthState get authState => _authState.value;

  @override
  void onInit() {
    super.onInit();
    // Check if the user is already authenticated on app start
    _checkAuthenticated();
  }

  void login(String username, String password) async {
    try {
      // Simulated API call to get token
      String token = await _getTokenFromAPI(username, password);

      // Store token securely
      await _secureStorage.write(key: 'token', value: token);

      // Update authState
      _authState.value = AuthState.authenticated;
    } catch (e) {
      // Handle error
      _authState.value = AuthState.unauthenticated;
    }
  }

  Future<void> _checkAuthenticated() async {
    // Check if token exists on app start
    String? token = await _secureStorage.read(key: 'token');
    if (token != null) {
      _authState.value = AuthState.authenticated;
    }
  }

  void logout() async {
    // Remove token from secure storage
    await _secureStorage.delete(key: 'token');
    _authState.value = AuthState.unauthenticated;
  }

  Future<String> _getTokenFromAPI(String username, String password) async {
    // Simulated API call, replace with actual API call
    await Future.delayed(const Duration(seconds: 2));
    return 'your_generated_token';
  }
}
