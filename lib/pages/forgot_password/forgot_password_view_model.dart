import 'dart:convert';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class ForgotPasswordViewModel {
  ForgotPasswordPageState state;
  String emailErrorMsg = '';
  ApiStatus apiStatus = ApiStatus.initial;
  RestConstants restConstantsInstance = RestConstants.instance;
  TextEditingController emailController = TextEditingController();

  ForgotPasswordViewModel(this.state);

  ///====================== Functions ==============================

  Future<void> resetPasswordButtonOnTap() async {
    // TODO: ResetPassword validation
    if (!ValidationUtils.validateEmptyController(emailController) &&
        ValidationUtils.regexValidator(emailController, ValidationUtils.emailRegExp)) {
      emailErrorMsg = '';
      apiStatus = ApiStatus.loading;
      state.forgotPasswordController.update();
      String response = await state.forgotPasswordController.forgotPassword(
              body: {'action': restConstantsInstance.forgetPassword, 'emailId': emailController.text.toString()}) ??
          '';
      if (response.isNotEmpty) {
        Map<String, dynamic> responseMap = jsonDecode(response);
        if (responseMap.containsKey('status') && responseMap['status'] == 'Success') {
          successToast(responseMap['msg']);
        }
        apiStatus = ApiStatus.success;
        goToBack();
      } else {
        apiStatus = ApiStatus.failed;
      }
    } else {
      emailErrorMsg = ValidationUtils.validateEmptyController(emailController)
          ? AppStringConstants.emailIdCanNotBeEmpty.tr
          : !ValidationUtils.regexValidator(emailController, ValidationUtils.emailRegExp)
              ? AppStringConstants.emailIdIsNotValid.tr
              : '';
    }
    state.forgotPasswordController.update();
  }

  ///====================== Views ==================================

  Widget loginBodyHeaderView() {
    return Container(
      height: Get.height * 0.48,
      color: AppColorConstants.appPrimary,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const AppImageAsset(
            image: AppAssetsConstants.loginBg,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          AppImageAsset(
            image: AppAssetsConstants.splashLogo,
            height: Get.height * 0.22,
          )
        ],
      ),
    );
  }

  Widget loginBodyFooterView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16).copyWith(top: 30),
      child: Column(
        children: [
          emailTextFieldView(),
          const SizedBox(height: 50),
          resetPasswordButtonView(),
          const SizedBox(height: 10),
          alreadyHaveAccountView()
        ],
      ),
    );
  }

  Widget emailTextFieldView() {
    return AppTextFormField(
      controller: emailController,
      errorMassage: emailErrorMsg,
      title: AppStringConstants.enterYourRegisteredEmailAddress.tr,
      hint: AppStringConstants.enterYourEmailAddress.tr,
      hintStyle: TextStyle(
        color: AppColorConstants.appPrimary,
        fontSize: 12,
        fontFamily: AppAssetsConstants.nunito,
      ),
      borderColor: AppColorConstants.lightGray,
      fillColor: AppColorConstants.lightGray,
    );
  }

  Widget resetPasswordButtonView() {
    return AppButton(
      onTap: resetPasswordButtonOnTap,
      text: AppStringConstants.resetPassword.tr,
      height: 46,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: AppAssetsConstants.nunito,
      borderRadius: BorderRadius.circular(40),
    );
  }

  Widget alreadyHaveAccountView() {
    return InkWell(
      overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
      onTap: () => goToBack(),
      child: RichText(
          text: TextSpan(
        text: AppStringConstants.dontHaveAnAccount.tr,
        style:
            const TextStyle(color: AppColorConstants.mediumGray, fontFamily: AppAssetsConstants.nunito, fontSize: 12),
        children: [
          TextSpan(
            text: ' ${AppStringConstants.login.tr}',
            style: TextStyle(
                color: AppColorConstants.appPrimary,
                fontFamily: AppAssetsConstants.nunito,
                fontWeight: FontWeight.w700,
                fontSize: 12),
          )
        ],
      )),
    );
  }
}
