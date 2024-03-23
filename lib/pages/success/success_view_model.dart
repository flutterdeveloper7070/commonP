import 'package:predator_pest/app/common_imports/common_imports.dart';


class SuccessViewModel{
  SuccessPageState state;
  SuccessViewModel(this.state);

  ///====================== Functions ==============================

  Future<void> sendMailAction() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: AppStringConstants.contactUsMail,
      // query: 'subject=App Feedback&body=App Version 3.23', //add subject and body here
    );

    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  ///====================== Views ==================================

  Widget successBodyView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: AppImageAsset(
            image: AppAssetsConstants.successIcon,
            color: AppColorConstants.goldenrod,
            height: Get.height * 0.2,
          ),
        ),
        const SizedBox(height: 16,),
        AppText(
          text: AppStringConstants.successful.tr,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: AppAssetsConstants.nunito,
          fontColor: AppColorConstants.appPrimary,
        ),
        const SizedBox(height: 16,),
        AppText(
          text: AppStringConstants.successMessage.tr,
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          fontFamily: AppAssetsConstants.nunito,
          fontColor: AppColorConstants.appPrimary,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        AppText(
          text: AppStringConstants.needHelp.tr,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: AppAssetsConstants.nunito,
          fontColor: AppColorConstants.appPrimary,
        ),
        const SizedBox(height: 5,),
        AppText(
          text: AppStringConstants.jamesDeBari.tr,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: AppAssetsConstants.nunito,
          fontColor: AppColorConstants.appPrimary,
        ),
        const SizedBox(height: 5,),
        InkWell(
          overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
          onTap: sendMailAction,
          child: const AppText(
            text: AppStringConstants.contactUsMail,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: AppAssetsConstants.nunito,
            fontColor: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 5,),
        InkWell(
          overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
          onTap: sendMailAction,
          child: const AppText(
            text: AppStringConstants.contactUsAddress,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: AppAssetsConstants.nunito,
            fontColor: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}