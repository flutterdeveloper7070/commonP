import 'dart:convert';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class LoginViewModel {
  LoginPageState state;
  String emailErrorMsg = '';
  String passwordErrorMsg = '';
  bool isPassWordVisible = true;
  ApiStatus apiStatus = ApiStatus.initial;
  RestConstants restConstantsInstance = RestConstants.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginViewModel(this.state) {
    Future.delayed(const Duration(milliseconds: 100), () async {
      ConnectivityService.instance.isConnectNetworkWithMessage();
      await ConnectivityService.instance.isCheckConnectivity();
    });
  }

  ///====================== Functions ==============================

  Future<void> loginButtonOnTap() async {
    // TODO: Login validation

    if (!ValidationUtils.validateEmptyController(emailController) &&
        !ValidationUtils.validateEmptyController(passwordController) &&
        ValidationUtils.regexValidator(emailController, ValidationUtils.emailRegExp)) {
      emailErrorMsg = '';
      passwordErrorMsg = '';
      apiStatus = ApiStatus.loading;
      state.loginController.update();
      await state.loginController.login(body: {
        'email': emailController.text.toString(),
        'password': passwordController.text.toString(),
      });
      if (state.loginController.loginModel != null) {
        apiStatus = ApiStatus.success;
        if (state.loginController.loginModel?.message != null &&
            state.loginController.loginModel!.message!.isNotEmpty) {
          successToast(state.loginController.loginModel?.message ?? '');
        }

        if (state.loginController.loginModel?.token != null && state.loginController.loginModel!.token!.isNotEmpty) {
          setPrefStringValue(AppSharedPreference.loginToken, state.loginController.loginModel!.token!);
        }
        if (state.loginController.loginModel?.loginResponse != null) {
          setPrefStringValue(
              AppSharedPreference.loginResponse, jsonEncode(state.loginController.loginModel?.loginResponse));
        }
        goToCheckList();
      } else {
        apiStatus = ApiStatus.failed;
      }
    } else {
      emailErrorMsg = ValidationUtils.validateEmptyController(emailController)
          ? AppStringConstants.emailIdCanNotBeEmpty.tr
          : !ValidationUtils.regexValidator(emailController, ValidationUtils.emailRegExp)
              ? AppStringConstants.emailIdIsNotValid.tr
              : '';
      passwordErrorMsg = ValidationUtils.validateEmptyController(passwordController)
          ? AppStringConstants.passwordCanNotBeEmpty.tr
          : '';
    }
    state.loginController.update();
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
          const SizedBox(height: 15),
          passwordTextFieldView(),
          const SizedBox(height: 8),
          // forgotPasswordView(),
          const SizedBox(height: 40),
          loginButtonView(),
        ],
      ),
    );
  }

  Widget emailTextFieldView() {
    return AppTextFormField(
      controller: emailController,
      errorMassage: emailErrorMsg,
      keyboardType: TextInputType.emailAddress,
      title: AppStringConstants.emailAddress.tr,
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

  Widget passwordTextFieldView() {
    return AppTextFormField(
      controller: passwordController,
      errorMassage: passwordErrorMsg,
      title: AppStringConstants.password.tr,
      hint: AppStringConstants.passwordHint,
      hintStyle: const TextStyle(
        color: AppColorConstants.mediumGray,
        fontFamily: AppAssetsConstants.nunito,
      ),
      borderColor: AppColorConstants.lightGray,
      fillColor: AppColorConstants.lightGray,
      isObscure: isPassWordVisible,
      suffixIcon: InkWell(
        onTap: () {
          isPassWordVisible = !isPassWordVisible;
          state.loginController.update();
        },
        child: Icon(
          isPassWordVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColorConstants.mediumGray,
        ),
      ),
    );
  }

  Widget forgotPasswordView() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
        onTap: () {
          goToForgotPassword();
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: AppText(
            text: AppStringConstants.forgotPassword.tr,
            fontSize: 11,
            fontFamily: AppAssetsConstants.nunito,
            fontColor: AppColorConstants.appPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget loginButtonView() {
    return AppButton(
      onTap: loginButtonOnTap,
      text: AppStringConstants.login.tr,
      height: 46,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: AppAssetsConstants.nunito,
      borderRadius: BorderRadius.circular(40),
    );
  }
}
