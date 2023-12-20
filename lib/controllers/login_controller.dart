import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

enum AuthState { authenticated, unauthenticated, loading }

class AuthController extends GetxController {
  final Rx<AuthState> _authState = AuthState.unauthenticated.obs;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final RxString token = ''.obs;
  final RxBool _isMineOfficial = false.obs;
  bool get isMineOfficial => _isMineOfficial.value;
  AuthState get authState => _authState.value;

  @override
  void onInit() {
    super.onInit();
    // Check if the user is already authenticated on app start
    _checkAuthenticated();
  }

  Future<String?> login(
      String phoneNumber, String password, bool isMineOfficialUser) async {
    _authState.value = AuthState.loading;
    try {
      // Simulated API call to get token
      String token = await _getTokenFromAPI(phoneNumber, password);

      // Store token securely
      await _secureStorage.write(key: 'token', value: phoneNumber);
      _isMineOfficial.value = isMineOfficialUser;
      await _secureStorage.write(
          key: 'isMineOfficial', value: isMineOfficialUser.toString());
      // Update authState
      _authState.value = AuthState.authenticated;
      return token;
    } catch (e) {
      // Handle error
      _authState.value = AuthState.unauthenticated;
      return null;
    }
  }

  Future<void> _checkAuthenticated() async {
    // Check if token exists on app start
    String? token = await _secureStorage.read(key: 'token');
    print(token);
    if (token!.isNotEmpty) {
      print("checked auth state");
      _authState.value = AuthState.authenticated;
      _isMineOfficial.value =
          await _secureStorage.read(key: 'isMineOfficial') == 'true';
    }
  }

  Future<void> logout() async {
    // Remove token from secure storage
    _authState.value = AuthState.unauthenticated;
    print("logout");
    await _secureStorage.deleteAll();
    _isMineOfficial.value = false;
  }

  Future<String?> getTokenFromDB() async {
    var token = await _secureStorage.read(key: 'token');
    print("token = $token");
    return token;
  }

  Future<String> _getTokenFromAPI(String phoneNumber, String password) async {
    // Simulated API call, replace with actual API call
    await Future.delayed(const Duration(seconds: 2));
    return phoneNumber;
  }
}
