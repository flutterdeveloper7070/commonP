import 'package:predator_pest/app/common_imports/common_imports.dart';

goToBack() {
  Get.back();
}

goToOnBoarding() {
  Get.offNamed(RouteHelper.onBoardingPage);
}

goToLogin({bool isOff = false}) {
  if (isOff) {
    Get.offAllNamed(RouteHelper.loginPage);
  } else {
    Get.toNamed(RouteHelper.loginPage);
  }
}

goToCheckList() {
  Get.offAllNamed(RouteHelper.checkListPage);
}

goToUploadMedia({required String formId}) {
  Get.toNamed(RouteHelper.uploadMediaPage, arguments: {'formId': formId});
}

goToForgotPassword() {
  Get.toNamed(RouteHelper.forgotPasswordPage);
}

goToSuccess() {
  Get.offAllNamed(RouteHelper.successPage);
}

goToProfile() {
  Get.toNamed(RouteHelper.profilePage);
}

logout() async {
  await removeAllPrefValue([
    AppSharedPreference.loginResponse,
    AppSharedPreference.loginToken,
  ]);
  goToLogin(isOff: true);
}