import 'package:predator_pest/app/common_imports/common_imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  LoginViewModel? loginViewModel;
  late LoginController loginController;

  @override
  Widget build(BuildContext context) {
    loginViewModel ?? (loginViewModel = LoginViewModel(this));
    return GetBuilder(
      init: LoginController(),
      builder: (controller) {
        loginController = controller;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(statusBarColor: AppColorConstants.appTransparent),
          child: Scaffold(
            body: Stack(
              children: [
                ListView(
                  physics: const ClampingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    loginViewModel!.loginBodyHeaderView(),
                    loginViewModel!.loginBodyFooterView(),
                  ],
                ),
                if (loginViewModel?.apiStatus == ApiStatus.loading) const AppLoader()
              ],
            ),
          ),
        );
      },
    );
  }
}
