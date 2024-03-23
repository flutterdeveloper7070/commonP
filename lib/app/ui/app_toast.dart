import 'package:predator_pest/app/common_imports/common_imports.dart';

void warningToast(String msg, Color color, {int? maxLine}) {
  BotToast.showNotification(
    // leading: (icons) => AppImageAsset(image: AssetsConstant.warning),
    title: (_) => Text(
      msg,
      style: const TextStyle(
          color: AppColorConstants.appWhite,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: AppAssetsConstants.nunito
      ),
    ),
    backgroundColor: color,
    borderRadius: 15.0,
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(seconds: 1),
  );
}

void successToast(String msg) {
  BotToast.showNotification(
    title: (_) => Text(
      msg,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w600,
          fontFamily: AppAssetsConstants.nunito
      ),
    ),
    backgroundColor: Colors.green,
    borderRadius: 10.0,
    duration: const Duration(seconds: 3),
    animationDuration: const Duration(seconds: 1),
  );
}

void errorToast(String msg) {
  BotToast.showNotification(
    title: (_) => Text(
      msg,
      style: const TextStyle(
        color: AppColorConstants.appWhite,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: AppAssetsConstants.nunito
      ),
    ),
    backgroundColor: AppColorConstants.appRed,
    borderRadius: 10.0,
    duration: const Duration(seconds: 5),
    animationDuration: const Duration(seconds: 1),
  );
}