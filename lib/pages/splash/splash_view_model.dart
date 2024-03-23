import 'package:predator_pest/app/common_imports/common_imports.dart';

class SplashViewModel {
  late SplashPageState state;

  SplashViewModel(this.state) {
    Future.delayed(const Duration(seconds: 3), () {
      userLoginOrNot();
    });
  }

  ///====================== Functions ==============================

  Future<void> userLoginOrNot() async {
    bool interCompleted = await getPrefBoolValue(AppSharedPreference.interCompleted); // interCompleted
    String loginResponse = await getPrefStringValue(AppSharedPreference.loginResponse) ?? '';
    if(loginResponse.isNotEmpty){
      goToCheckList();
    }else if(interCompleted){
      goToLogin(isOff: true);
    }else{
      goToOnBoarding();
    }
  }


  ///====================== Views ==================================

  Widget splashBodyView() {
    return  const Stack(
      children: [
        AppImageAsset(
          image: AppAssetsConstants.splashBg,
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.all(86),
            child: AppImageAsset(
              image: AppAssetsConstants.splashLogo,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
