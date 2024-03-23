import 'dart:developer';

import 'package:predator_pest/app/common_imports/common_imports.dart';

class ConnectivityService {
  ConnectivityService._privateConstructor();

  static final ConnectivityService instance = ConnectivityService._privateConstructor();
  late Connectivity connectivity = Connectivity();
  late ConnectivityResult result;
  late bool isConnected = false;
  bool isDialogOpen = false;

  Future<void> isConnectNetworkWithMessage({bool isMain = false}) async {
    connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) async {
      isConnected = await updateConnectionStatus(connectivityResult);
      if (!isConnected && !isDialogOpen && !isMain) {
        commonNoInterNetDialog();
      }
    });
  }

  Future<bool> isCheckConnectivity() async {
    result = await connectivity.checkConnectivity();
    isConnected = await updateConnectionStatus(result);
    if (!isConnected && !isDialogOpen) {
      commonNoInterNetDialog();
    }
    return isConnected;
  }

  Future<bool> updateConnectionStatus(ConnectivityResult connectivityResult) async {
    log("Connection Status: $connectivityResult");
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.ethernet ||
        connectivityResult == ConnectivityResult.vpn ||
        connectivityResult == ConnectivityResult.other) {
      log("Connected");
      return true;
    } else if(connectivityResult == ConnectivityResult.none) {
      log("Not Connected");
      return false;
    }else {
      return true;
    }
  }

  void commonNoInterNetDialog({Function? onPressed}) {
    isDialogOpen = true;
    commonAlertDialog(
        barrierDismissible: false,
        isBackOff: false,
        titleWidget: AppText(
          text: AppStringConstants.noInternetConnection.tr,
          textStyle: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(
                fontSize: 18,
                color: AppColorConstants.appBlack,
              ),
        ),
        contentWidget: AppText(
          text: AppStringConstants.pleaseCheckYourInternetConnectionAndTryAgain.tr,
          textStyle: Theme.of(Get.context!).textTheme.displaySmall!.copyWith(
                fontSize: 14,
                color: AppColorConstants.appBlack.withOpacity(0.4),
              ),
        ),
        actions: [
          TextButton(
            child: AppText(
              text: AppStringConstants.tryAgain.tr,
            ),
            onPressed: () async {
              bool isConnect = await isCheckConnectivity();
              if (isConnect) {
                if (onPressed != null) {
                  onPressed();
                }
                isDialogOpen = false;
                Navigator.pop(Get.context!);
              }
            },
          ),
        ]);
  }
}
