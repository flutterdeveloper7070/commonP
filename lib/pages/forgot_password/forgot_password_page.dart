import 'package:predator_pest/app/common_imports/common_imports.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  ForgotPasswordViewModel? forgotPasswordViewModel;
  late ForgotPasswordController forgotPasswordController;

  @override
  Widget build(BuildContext context) {
    forgotPasswordViewModel ?? (forgotPasswordViewModel = ForgotPasswordViewModel(this));
    return GetBuilder(
      init: ForgotPasswordController(),
      builder: (controller) {
        forgotPasswordController = controller;
        return Scaffold(
          body: Stack(
            children: [
              ListView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                children: [
                  forgotPasswordViewModel!.loginBodyHeaderView(),
                  forgotPasswordViewModel!.loginBodyFooterView(),
                ],
              ),
              if (forgotPasswordViewModel?.apiStatus == ApiStatus.loading) const AppLoader()
            ],
          ),
        );
      },
    );
  }
}
