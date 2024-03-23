import 'package:predator_pest/app/common_imports/common_imports.dart';

class AppStringConstants {

  //     ======================= Strings =======================     //
  static const String appName = 'IPM Reports';
  static const String appNameDev = 'Dev IPM Reports';
  static const String passwordHint = '********';
  static const String contactUsMail = 'pred8orpc@gmail.com';
  static const String contactUsAddress = 'P.O. Box 140352 Howard Beach N.Y. 11414';

  //     ======================= Localization Keys =======================     //

  static const String somethingWentWrong = 'somethingWentWrong';
  static const String readMore = 'readMore';
  static const String readLess = 'readLess';
  static const String skip = 'skip';
  static const String onBoardingTitle1 = 'onBoardingTitle1';
  static const String onBoardingTitle2 = 'onBoardingTitle2';
  static const String onBoardingDescription1 = 'onBoardingDescription1';
  static const String onBoardingDescription2 = 'onBoardingDescription2';
  static const String next = 'next';
  static const String dateFormat = 'dateFormat';
  static const String emailAddress = 'emailAddress';
  static const String enterYourEmailAddress = 'enterYourEmailAddress';
  static const String password = 'password';
  static const String forgotPassword = 'forgotPassword';
  static const String login = 'login';
  static const String checkListTitle = 'checkListTitle';
  static const String typeHere = 'typeHere';
  static const String submit = 'submit';
  static const String noMediaFound = 'noMediaFound';
  static const String uploadImagesFromMediaLibrary = 'uploadImagesFromMediaLibrary';
  static const String uploadFile = 'uploadFile';
  static const String dontHaveAnAccount = 'dontHaveAnAccount';
  static const String enterYourRegisteredEmailAddress = 'enterYourRegisteredEmailAddress';
  static const String resetPassword = 'resetPassword';
  static const String description = 'description';
  static const String writeHere = 'writeHere';
  static const String clickWithCamera = 'clickWithCamera';
  static const String account = 'account';
  static const String welcomeBack = 'welcomeBack';
  static const String pestProblems = 'pestProblems';
  static const String sanitationIssues = 'sanitationIssues';
  static const String structuralIssues = 'structuralIssues';
  static const String recommendCorrectiveMeasures = 'recommendCorrectiveMeasures';
  static const String inspectionMonitorResults = 'inspectionMonitorResults';
  static const String selectLocations = 'selectLocations';
  static const String accountFieldShouldNotBeEmpty = 'accountFieldShouldNotBeEmpty';
  static const String appPermission = 'appPermission';
  static const String permissionGrantCamera = 'permissionGrantCamera';
  static const String permissionGrantLocation = 'permissionGrantLocation';
  static const String settings = 'settings';
  static const String success = 'success';
  static const String emailIdCanNotBeEmpty = 'emailIdCanNotBeEmpty';
  static const String emailIdIsNotValid = 'emailIdIsNotValid';
  static const String passwordCanNotBeEmpty = 'passwordCanNotBeEmpty';
  static const String loginSuccessful = 'loginSuccessful';
  static const String successful = 'successful';
  static const String successMessage = 'successMessage';
  static const String needHelp = 'needHelp';
  static const String jamesDeBari = 'jamesDeBari';
  static const String mediaUploadedSuccessfully = 'mediaUploadedSuccessfully';
  static const String pleaseSelectImage = 'pleaseSelectImage';
  static const String youAreAbleToUploadOnlyImages = 'youAreAbleToUploadOnlyImages';
  static const String noInternetConnection = 'noInternetConnection';
  static const String pleaseCheckYourInternetConnectionAndTryAgain = 'pleaseCheckYourInternetConnectionAndTryAgain';
  static const String tryAgain = 'tryAgain';
  static const String areYouSure = 'areYouSure';
  static const String doYouWantToLogout = 'doYouWantToLogout';
  static const String yes = 'yes';
  static const String no = 'no';
  static const String lastName = 'lastName';
  static const String firstName = 'firstName';
  static const String profile = 'profile';
  static const String permissionGrantStorage = 'permissionGrantStorage';
  static const String dateOfBirth = 'dateOfBirth';
  static const String phoneNumber = 'phoneNumber';
  static const String location = 'location';

}


class AppColorConstants {

  static Color appPrimary = const Color(0xFF1D222A);
  static const Color appWhite = Color(0xffffffff);
  static const Color appRed = Color(0xffF64444);
  static const Color appBlack = Color(0xFF000000);
  static const Color appGray = Colors.grey;
  static const Color blueAccent = Colors.blueAccent;
  static const Color silverGray = Color(0xFFC4C4C4);
  static const Color literGray = Color(0xFFFAFAFA);
  static const Color veryLightGray = Color.fromRGBO(249, 249, 249, 1);
  static const Color mediumGray = Color(0xffA2A2A2);
  static const Color midnightBlue = Color(0xff01041D);
  static const Color appBorderColor = Color.fromRGBO(11, 11, 11, 0.27);
  static const Color appTransparent = Colors.transparent;
  static  Color dividerColorLight = appBlack.withOpacity(0.1);
  static  Color dividerColorDark = appWhite.withOpacity(0.1);
  static const Color buttonDisableColor= Color.fromRGBO(110, 104, 104, 1);
  static const Color appContinueButtonTextColor = Color(0xff6E6868);
  static const Color appTextFieldBorderColor = Color(0xffC7C5C5);
  static const Color lightGray = Color(0xffF0F0F0);
  static const Color goldenrod = Color(0xffFFCF53);
  static const Color charcoalGray = Color(0xff545454);

}

class AppAssetsConstants {
  static const String quicksand = 'Quicksand';
  static const String defaultFont = 'Futura';
  static const String montserrat = 'Montserrat';
  static const String nunito = 'Nunito';
  static const String imagePath = 'assets/images/';
  static const String iconPath = 'assets/icons/';
  static const String animPath = 'assets/anim/';

  // =================== icons ========================= //
  static const String splashAnim = '${animPath}splash_anim.json';

  // =================== images ========================= //
  static const String splashBg = '${imagePath}img_splash_bg.png';
  static const String splashLogo = '${imagePath}img_app_logo1-min.png';
  static const String onBoardingImg1 = '${imagePath}img_on_boarding.png';
  static const String onBoardingImg2 = '${imagePath}img_on_boarding_2.png';
  static const String loginBg = '${imagePath}img_login_bg.png';

  // =================== icons ========================= //
  static const String defaultUser = '${iconPath}ic_default_user.svg';
  static const String logout = '${iconPath}ic_logout.svg';
  static const String checkBox = '${iconPath}ic_check_box.svg';
  static const String checkBoxTick = '${iconPath}ic_check_box_tick.svg';
  static const String uploadMedia = '${iconPath}ic_upload_media.svg';
  static const String cameraIcon = '${iconPath}ic_camera.svg';
  static const String galleryIcon = '${iconPath}ic_gallery.svg';
  static const String successIcon = '${iconPath}ic_success.svg';

}