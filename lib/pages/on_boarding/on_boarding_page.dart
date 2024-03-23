import 'dart:io';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  OnBoardingViewModel? onBoardingViewModel;
  late OnBoardingController onBoardingController;

  @override
  Widget build(BuildContext context) {
    onBoardingViewModel = (onBoardingViewModel = OnBoardingViewModel(this));
    return GetBuilder(
      init: OnBoardingController(),
      builder: (controller) {
        onBoardingController = controller;
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Platform.isAndroid ? AppColorConstants.appTransparent : AppColorConstants.silverGray,
          ),
          child: Scaffold(
            body: onBoardingViewModel?.onBoardingBodyView() ?? const SizedBox(),
          ),
        );
      },
    );
  }
}
