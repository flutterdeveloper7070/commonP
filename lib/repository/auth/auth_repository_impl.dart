import 'package:predator_pest/app/common_imports/common_imports.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future auth({required Map<String, String> body}) async {
    final response = await RestServices.instance.postRestCall(
      endpoint: RestConstants.instance.loginEndPoint,
      body: body,
      isLogin: true,
    );
    return response;
  }
}
