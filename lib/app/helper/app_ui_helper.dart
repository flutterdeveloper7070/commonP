import 'package:predator_pest/app/common_imports/common_imports.dart';

final value = NumberFormat("#,##,##0", "en_US");

writeAmount(num a) {
  //return a.toString();
  return value.format(a);
}

getSize(double val) {
  return val.sp;
}

getVerySmallFontSize() {
  return 10.0.sp;
}

getSmallFontSize() {
  return 12.0.sp;
}

getMedFontSize() {
  return 14.0.sp;
}

getLargeFontSize() {
  return 16.0.sp;
}

getVeryLargeFontSize() {
  return 18.0.sp;
}

getLightFontWeight() {
  return FontWeight.w100;
}

getMediumFontWeight() {
  return FontWeight.w500;
}

getBoldFontWeight() {
  return FontWeight.w900;
}

debugLogs(r) {
  debugPrint("$r");
}

showMessage(message, {isError, isDelayForBack}) async {
  //BotToast.showText(text: message, duration: const Duration(seconds: 5));
  if (isDelayForBack ?? false) {
    await Future.delayed(const Duration(milliseconds: 500));
  }
  Get.snackbar('', message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: (isError != null && isError) ? Colors.redAccent : AppColorConstants.appPrimary,
      colorText: Colors.white);
}

getAppDivider({thickness}) {
  return Divider(color: AppColorConstants.appGray, thickness: thickness ?? getSize(5));
}

Future appPermissionDialog(BuildContext context, PermissionType permissionType) {
  return showDialog(
    context: context,
    barrierColor: AppColorConstants.appBorderColor.withOpacity(0.8),
    builder: (context) => AlertDialog(
      title: AppText(
        text: AppStringConstants.appPermission.tr,
        fontSize: 17,
        fontWeight: FontWeight.w700,
        fontColor: AppColorConstants.appPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: AppText(
          text: permissionType == PermissionType.camera
              ? AppStringConstants.permissionGrantCamera.tr
              : permissionType == PermissionType.location
                  ? AppStringConstants.permissionGrantLocation.tr
                  : permissionType == PermissionType.storage
                      ? AppStringConstants.permissionGrantStorage.tr
                      : '',
          textAlign: TextAlign.start,
          fontSize: 12,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: AppButton(
            text: AppStringConstants.settings.tr,
            height: 38,
            fontSize: 14,
            onTap: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
          ),
        )
      ],
    ),
  );
}

commonAlertDialog(
    {Widget? titleWidget,
    Widget? contentWidget,
    List<Widget>? actions,
    bool barrierDismissible = true,
    bool isBackOff = true}) {
  return showDialog(
      context: Get.context!,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(isBackOff),
          child: AlertDialog(
            shape: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColorConstants.appWhite),
                borderRadius: BorderRadius.circular(20)),
            elevation: 1,
            shadowColor: AppColorConstants.appGray,
            title: titleWidget ?? const SizedBox(),
            content: contentWidget ?? const SizedBox(),
            actions: actions,
          ),
        );
      });
}
