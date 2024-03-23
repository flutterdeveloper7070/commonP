import 'package:predator_pest/app/common_imports/common_imports.dart';

class RouteHelper {
  static const String routeInitial = '/';
  static const String onBoardingPage = '/onBoardingPage';
  static const String loginPage = '/loginPage';
  static const String checkListPage = '/checkListPage';
  static const String uploadMediaPage = '/uploadMediaPage';
  static const String forgotPasswordPage = '/forgotPasswordPage';
  static const String successPage = '/successPage';
  static const String profilePage = '/profilePage';

  static List<GetPage> routes = [
    GetPage(name: routeInitial, page: () => const SplashPage()),
    GetPage(name: onBoardingPage, page: () => const OnBoardingPage()),
    GetPage(name: loginPage, page: () => const LoginPage()),
    GetPage(name: checkListPage, page: () => const CheckListPage()),
    GetPage(name: uploadMediaPage, page: () => const UploadMediaPage()),
    GetPage(name: forgotPasswordPage, page: () => const ForgotPasswordPage()),
    GetPage(name: successPage, page: () => const SuccessPage()),
    GetPage(name: profilePage, page: () => const ProfilePage()),
  ];
}
