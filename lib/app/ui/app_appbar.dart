import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppAppbar extends PreferredSize {
  final String userName;
  final String userImageUrl;
  final String title;
  final GestureTapCallback? backOnTap;

  AppAppbar({
    super.key,
    this.userName = '',
    this.userImageUrl = '',
    this.title = '',
    this.backOnTap,
    Widget? child,
    Size? preferredSize,
  }) : super(child: Container(), preferredSize: const Size.fromHeight(70));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            title.isNotEmpty
                ? InkWell(
                    overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
                    onTap: () => backOnTap?.call(),
                    child: SizedBox(
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColorConstants.appPrimary,
                          size: 21,
                        )))
                : InkWell(
                    overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
                    onTap: () => goToProfile(),
                    child: CircleAvatar(
                      backgroundColor: AppColorConstants.appTransparent,
                      radius: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AppImageAsset(
                          image: userImageUrl.isNotEmpty && !userImageUrl.contains('localhost:')
                              ? userImageUrl
                              : AppAssetsConstants.defaultUser,
                          color: AppColorConstants.mediumGray,
                        ),
                      ),
                    ),
                  ),
            if (title.isEmpty) const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (title.isEmpty)
                    AppText(
                      text: AppStringConstants.welcomeBack.tr,
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      fontColor: AppColorConstants.mediumGray,
                    ),
                  if (title.isEmpty)
                    AppText(
                      text: 'Hi, $userName!',
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  if (title.isNotEmpty)
                    Center(
                      child: AppText(
                        text: title,
                        fontWeight: FontWeight.w700,
                        fontSize: 17.5,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
              onTap: () => logOutButtonAction(),
              child: const Padding(
                padding: EdgeInsets.only(top: 17.5, bottom: 17.5),
                child: AppImageAsset(image: AppAssetsConstants.logout),
              ),
            )
          ],
        ),
      ),
    );
  }

  logOutButtonAction() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: AppText(
            text: AppStringConstants.areYouSure.tr,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontColor: AppColorConstants.appBlack,
            fontFamily: AppAssetsConstants.nunito,
          ),
          content: AppText(
            text: AppStringConstants.doYouWantToLogout.tr,
            fontSize: 13,
            fontFamily: AppAssetsConstants.nunito,
          ),
          actions: [
            InkWell(
              overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
              onTap: () async => logout(),
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: AppText(
                  text: AppStringConstants.yes.tr,
                  fontSize: 14.3,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColorConstants.blueAccent,
                  fontFamily: AppAssetsConstants.nunito,
                ),
              ),
            ),
            InkWell(
              overlayColor: const MaterialStatePropertyAll(AppColorConstants.appTransparent),
              onTap: () => goToBack(),
              child: Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: AppText(
                  text: AppStringConstants.no.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColorConstants.appGray,
                  fontFamily: AppAssetsConstants.nunito,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
