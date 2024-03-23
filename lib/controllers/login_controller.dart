import 'package:predator_pest/app/common_imports/common_imports.dart';

class LoginController extends GetxController {
  AuthRepository authRepository = getIt<AuthRepository>();
  LoginModel? loginModel;

  Future<void> login({required Map<String, String> body}) async {
    String? response = await authRepository.auth(body: body);
    if (response != null) {
      loginModel = loginModelFromJson(response);
    }
  }
}
