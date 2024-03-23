import 'dart:async';

import 'package:predator_pest/app/common_imports/common_imports.dart';

final getIt = GetIt.instance;

init() {
  getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  getIt.registerSingleton<CheckListRepository>(CheckListRepositoryImpl());
  getIt.registerSingleton<UploadMediaRepository>(UploadMediaRepositoryImpl());
}

Future<void> interNetConnectionCheck() async {
  ConnectivityService connectivityService = ConnectivityService.instance;
  connectivityService.isConnectNetworkWithMessage(isMain: true);
}

Future<void> main() async {
  AppConfig.create(
    appName: AppStringConstants.appName,
    baseUrl: "",
    flavor: Flavor.prod,
  );

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    init();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(
      const MyApp(),
    );
  }, (error, stack) {});
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static MyAppState? of(BuildContext context) => context.findAncestorStateOfType<MyAppState>();

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    interNetConnectionCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return Sizer(builder: (BuildContext context, Orientation orientation, screenType) {
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: GetMaterialApp(
          title: AppConfig.shared.appName,
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(microseconds: 800),
          scrollBehavior: ScrollHelper(),
          getPages: RouteHelper.routes,
          initialRoute: RouteHelper.routeInitial,
          theme: ThemeData.light(),
          translations: AppLocalization(),
          locale: Get.deviceLocale,
          navigatorObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
              child: child = botToastBuilder(context, child),
            );
          },
        ),
      );
    });
  }
}
