import 'package:predator_pest/app/common_imports/common_imports.dart';

class ForgotPasswordController extends GetxController {
  AuthRepository authRepository = getIt<AuthRepository>();

  Future<String?> forgotPassword({required Map<String, String> body}) async {
    String? response = await authRepository.auth(body: body);
    return response;
  }
}
