import 'dart:io' show Platform;
import 'package:predator_pest/app/common_imports/common_imports.dart';

class OnBoardingViewModel {
  late OnBoardingPageState state;
  PageController? pageController;
  int sectPage = 0;
  List<Map<String, dynamic>> onBoardingData = [
    {
      'image': AppAssetsConstants.onBoardingImg1,
      'title': AppStringConstants.onBoardingTitle1.tr,
      'description': AppStringConstants.onBoardingDescription1.tr,
    },
    {
      'image': AppAssetsConstants.onBoardingImg2,
      'title': AppStringConstants.onBoardingTitle2.tr,
      'description': AppStringConstants.onBoardingDescription2.tr,
    },
  ];

  OnBoardingViewModel(this.state) {
    pageController = PageController(initialPage: 0, keepPage: true);
    pageController?.addListener(() {
      sectPage = pageController?.page?.toInt() ?? 0;
      state.onBoardingController.update();
    });
  }

  ///====================== Functions ==============================

  void nextButtonAction({bool isSkip = false}) {
    if (sectPage == 1 || isSkip) {
      goToLogin(isOff: true);
      setPrefBoolValue(AppSharedPreference.interCompleted, true);
    } else if (sectPage == 0) {
      pageController?.animateToPage(1, duration: const Duration(milliseconds: 600), curve: Curves.ease);
    }
  }

  ///====================== Views ==================================

  Widget onBoardingBodyView() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColorConstants.silverGray, AppColorConstants.appWhite],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: Platform.isAndroid ? 23 : 10),
          skipButtonView(),
          introView(),
          const SizedBox(height: 20),
          indicatorView(),
          const Spacer(),
          nextButtonView(),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget skipButtonView() {
    return Align(
        alignment: Alignment.topRight,
        child: InkWell(
          overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
          onTap: () => nextButtonAction(isSkip: true),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppText(
              text: AppStringConstants.skip.tr,
              fontSize: 13.5,
              fontWeight: FontWeight.w400,
              fontFamily: AppAssetsConstants.quicksand,
              fontColor: AppColorConstants.midnightBlue.withOpacity(0.5),
            ),
          ),
        ));
  }

  Widget introView() {
    return SizedBox(
      height: MediaQuery.of(state.context).size.height * 0.65,
      child: PageView.builder(
        itemCount: onBoardingData.length,
        controller: pageController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8, left: 8, bottom: 15),
                  child: AppImageAsset(
                    image: onBoardingData[index]['image'],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 20),
                    child: AppText(
                      text: onBoardingData[index]['title'],
                      fontWeight: FontWeight.w700,
                      fontFamily: AppAssetsConstants.montserrat,
                      fontSize: 21,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: AppText(
                      text: onBoardingData[index]['description'],
                      textAlign: TextAlign.center,
                      fontSize: 12.5,
                      fontFamily: AppAssetsConstants.quicksand,
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget indicatorView() {
    return DotsIndicator(
      dotsCount: onBoardingData.length,
      position: sectPage,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      decorator: const DotsDecorator(
        size: Size(5, 5),
        activeSize: Size(5, 5),
      ),
    );
  }

  Widget nextButtonView() {
    return Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: nextButtonAction,
          child: Container(
            height: 43,
            width: 95,
            decoration: BoxDecoration(
              color: AppColorConstants.appPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: AppStringConstants.next.tr,
                  fontFamily: AppAssetsConstants.quicksand,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColorConstants.appWhite,
                ),
                const SizedBox(
                  width: 6,
                ),
                const Icon(
                  Icons.arrow_forward_sharp,
                  color: AppColorConstants.appWhite,
                  size: 16,
                )
              ],
            ),
          ),
        ));
  }
}
